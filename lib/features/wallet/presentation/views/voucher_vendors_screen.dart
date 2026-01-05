import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/wallet/domain/entities/voucher_store_entity.dart';
import 'package:gazzer/features/wallet/presentation/cubit/voucher_vendors_cubit.dart';
import 'package:gazzer/features/wallet/presentation/cubit/voucher_vendors_state.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_cubit.dart';

class VoucherVendorsScreen extends StatefulWidget {
  final String title;
  final int pointsNeed;
  final int id;
  final double availablePoints;

  const VoucherVendorsScreen({super.key, required this.title, required this.id, required this.availablePoints, required this.pointsNeed});

  static const route = '/voucher-vendors';

  @override
  State<VoucherVendorsScreen> createState() => _VoucherVendorsScreenState();
}

class _VoucherVendorsScreenState extends State<VoucherVendorsScreen> {
  final Set<VoucherStoreEntity> _selectedStores = {};

  int get _totalPointsUsed {
    return _selectedStores.length * widget.pointsNeed;
  }

  double get _remainingPoints {
    return widget.availablePoints - _totalPointsUsed;
  }

  bool _canSelectStore(VoucherStoreEntity store) {
    if (_selectedStores.contains(store)) return true; // Can always deselect
    return _remainingPoints >= widget.pointsNeed;
  }

  void _toggleStoreSelection(VoucherStoreEntity store) {
    setState(() {
      if (_selectedStores.contains(store)) {
        _selectedStores.remove(store);
      } else if (_canSelectStore(store)) {
        _selectedStores.add(store);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<VoucherVendorsCubit>().loadVoucherStores(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          // Refresh wallet data when going back
          try {
            final walletCubit = context.read<WalletCubit>();
            walletCubit.load(forceRefresh: true);
          } catch (_) {
            // WalletCubit not available in context, ignore
          }
        }
      },
      child: Scaffold(
        appBar: MainAppBar(title: widget.title),
        body: BlocConsumer<VoucherVendorsCubit, VoucherVendorsState>(
          listener: (context, state) {
            if (state is VoucherVendorsError) {
              Alerts.showToast(state.message);
            } else if (state is VoucherVendorsConvertSuccess) {
              Alerts.showToast(state.message, error: false);
              // Navigate back and refresh wallet
              try {
                final walletCubit = context.read<WalletCubit>();
                walletCubit.load(forceRefresh: true);
              } catch (_) {
                // WalletCubit not available in context, ignore
              }
              Navigator.of(context).pop();
            } else if (state is VoucherVendorsConvertError) {
              Alerts.showToast(state.message);
            }
          },
          builder: (context, state) {
            if (state is VoucherVendorsLoading) {
              return const Center(child: LoadingWidget());
            }

            if (state is VoucherVendorsError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message, style: TStyle.blackRegular(16), textAlign: TextAlign.center),
                    const VerticalSpacing(16),
                    MainBtn(
                      onPressed: () => context.read<VoucherVendorsCubit>().loadVoucherStores(widget.id),
                      text: L10n.tr().tryAgain,
                      bgColor: Co.purple,
                    ),
                  ],
                ),
              );
            }

            if (state is VoucherVendorsLoaded ||
                state is VoucherVendorsConverting ||
                state is VoucherVendorsConvertError ||
                state is VoucherVendorsConvertSuccess) {
              final stores = state is VoucherVendorsLoaded
                  ? state.stores
                  : state is VoucherVendorsConverting
                  ? state.stores
                  : state is VoucherVendorsConvertError
                  ? state.stores
                  : (state as VoucherVendorsConvertSuccess).stores;

              if (stores.isEmpty) {
                return Center(child: Text(L10n.tr().noData, style: TStyle.blackRegular(16)));
              }

              final isConverting = state is VoucherVendorsConverting;

              return Column(
                children: [
                  // Points summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Co.purple100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Co.purple),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${L10n.tr().available}: ${widget.availablePoints.toInt()} ${L10n.tr().points}', style: TStyle.blackRegular(14)),
                            const SizedBox(height: 4),
                            Text('${L10n.tr().selected}: $_totalPointsUsed ${L10n.tr().points}', style: TStyle.blackRegular(14)),
                            const SizedBox(height: 4),
                            Text(
                              '${L10n.tr().remaining}: ${_remainingPoints.toInt()} ${L10n.tr().points}',
                              style: TStyle.robotBlackRegular14().copyWith(
                                fontWeight: TStyle.bold,
                                color: _remainingPoints < 0 ? Colors.red : Co.purple,
                              ),
                            ),
                          ],
                        ),
                        if (_selectedStores.isNotEmpty)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: Co.purple, borderRadius: BorderRadius.circular(20)),
                            child: Text('${_selectedStores.length} ${L10n.tr().selected}', style: TStyle.whiteBold(12)),
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (context, index) {
                        final store = stores[index];
                        final isSelected = _selectedStores.contains(store);
                        final canSelect = _canSelectStore(store);
                        return _VendorTile(
                          store: store,
                          isSelected: isSelected,
                          canSelect: canSelect,
                          pointsNeed: widget.pointsNeed,
                          onTap: () => _toggleStoreSelection(store),
                        );
                      },
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: stores.length,
                    ),
                  ),
                  if (_selectedStores.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Co.white,
                        boxShadow: [BoxShadow(color: Co.lightGrey.withOpacityNew(0.3), blurRadius: 10, offset: const Offset(0, -5))],
                      ),
                      child: SafeArea(
                        child: MainBtn(
                          onPressed: () {
                            final voucherCodes = _selectedStores.map((s) => s.voucherCode).toList();
                            if (voucherCodes.length == 1) {
                              context.read<VoucherVendorsCubit>().convertVoucher(voucherCodes.first);
                            } else {
                              context.read<VoucherVendorsCubit>().convertMultipleVouchers(voucherCodes);
                            }
                          },
                          text: L10n.tr().submit,
                          bgColor: Co.purple,
                          isLoading: isConverting,
                          isEnabled: !isConverting && _remainingPoints >= 0,
                        ),
                      ),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _VendorTile extends StatelessWidget {
  const _VendorTile({required this.store, required this.isSelected, required this.canSelect, required this.pointsNeed, required this.onTap});

  final VoucherStoreEntity store;
  final bool isSelected;
  final bool canSelect;
  final int pointsNeed;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final discountText = store.discountType == 'percentage' ? '${store.discountValue}%' : '${store.discountValue} ${L10n.tr().egp}';

    final isDisabled = !canSelect && !isSelected;

    return InkWell(
      onTap: isDisabled ? null : onTap,
      borderRadius: BorderRadius.circular(16),
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? Co.purple100 : Co.bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? Co.purple
                  : isDisabled
                  ? Co.lightGrey
                  : Co.lightGrey,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Checkbox(
              //   value: isSelected,
              //   onChanged: isDisabled ? null : (_) => onTap(),
              //   activeColor: Co.purple,
              // ),
              // const SizedBox(width: 12),
              CustomNetworkImage(
                store.image, // Store image URL if available in API
                height: 60,
                width: 60,
                borderRaduis: 16,
                fit: BoxFit.cover,
                errorWidget: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(color: Co.secondary, borderRadius: BorderRadius.circular(16)),
                  child: const Icon(Icons.store, color: Co.white, size: 30),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(L10n.isAr(context) ? store.storeNameAr : store.storeName, style: TStyle.robotBlackMedium()),
                    const SizedBox(height: 4),
                    Text('$discountText ${L10n.tr().discount}', style: textTheme.bodySmall?.copyWith(color: Co.darkGrey)),
                    const SizedBox(height: 4),
                    Text(L10n.tr().walletValidUntil(store.validUntil), style: textTheme.bodySmall?.copyWith(color: Co.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
