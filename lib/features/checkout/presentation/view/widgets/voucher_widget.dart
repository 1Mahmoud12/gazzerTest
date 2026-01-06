import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/custom_dropdown.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/checkoutCubit/checkout_states.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_cubit.dart';
import 'package:gazzer/features/checkout/presentation/cubit/voucherCubit/vouchers_states.dart';
import 'package:gazzer/features/checkout/presentation/view/widgets/voucher_alert_widget.dart';

class VoucherWidget extends StatefulWidget {
  const VoucherWidget({super.key});

  @override
  State<VoucherWidget> createState() => _VoucherWidgetState();
}

class _VoucherWidgetState extends State<VoucherWidget> {
  late final TextEditingController _voucherController;

  @override
  void initState() {
    super.initState();
    _voucherController = TextEditingController();
  }

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VouchersCubit, VouchersStates>(
      builder: (context, state) {
        final cubit = context.read<VouchersCubit>();
        if (cubit.vouchers.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          padding: const EdgeInsets.all(16),

          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(L10n.tr().havePromoCode, style: TStyle.robotBlackRegular(), textAlign: TextAlign.start),
                  if (!cubit.isTextFieldEnabled) ...[
                    const VerticalSpacing(10),
                    BlocBuilder<CheckoutCubit, CheckoutStates>(
                      builder: (context, state) {
                        final checkoutCubit = context.read<CheckoutCubit>();
                        final appliedVoucher = checkoutCubit.voucherCode;
                        final hasVoucher = appliedVoucher != null && appliedVoucher.isNotEmpty;

                        return Row(
                          children: [
                            BlocListener<VouchersCubit, VouchersStates>(
                              listener: (context, state) {
                                if (state is VoucherError) {
                                  voucherAlert(title: state.message, context: context);
                                }
                              },
                              child: Expanded(
                                child: Builder(
                                  builder: (context) {
                                    // Determine currently selected voucher entity
                                    final vouchers = cubit.vouchers;
                                    VoucherDTO selectedVoucher;
                                    if (hasVoucher) {
                                      selectedVoucher = vouchers.firstWhere(
                                        (v) => v.code == appliedVoucher,
                                        orElse: () => VoucherDTO(code: L10n.tr().select_voucher, discountType: '', discountValue: ''),
                                      );
                                    } else if (cubit.selectedVoucherCode != null) {
                                      selectedVoucher = vouchers.firstWhere((v) => v.code == cubit.selectedVoucherCode, orElse: () => vouchers.first);
                                    } else {
                                      selectedVoucher = VoucherDTO(code: '', discountType: '', discountValue: '');
                                    }

                                    return CustomDropdown<VoucherDTO>(
                                      items: vouchers,
                                      selectedItem: selectedVoucher,
                                      onChanged: (voucher) {
                                        final code = voucher.code;
                                        if (code.isEmpty) return;
                                        _voucherController.text = code;
                                        cubit.applyLocalVoucher(code);
                                        checkoutCubit.applyVoucher(code);
                                      },
                                      itemBuilder: (context, voucher) {
                                        final code = voucher.code;
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(code),
                                            if (cubit.selectedVoucherCode != code)
                                              Text('${voucher.discountValue} ${voucher.discountType.contains('percent') ? '%' : L10n.tr().egp}'),
                                          ],
                                        );
                                      },
                                      selectedItemBuilder: (context, voucher) {
                                        final code = voucher.code;
                                        return Text(
                                          code.isEmpty ? L10n.tr().selectVoucher : code,
                                          style: TStyle.robotBlackRegular().copyWith(color: code.isEmpty ? Co.darkGrey : Co.black),
                                        );
                                      },
                                      borderRadius: AppConst.defaultBorderRadius.topLeft.x,
                                      borderColor: Co.lightGrey,
                                      fillColor: Co.white,
                                      buttonPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                      menuMaxHeight: 300,
                                    );
                                  },
                                ),
                              ),
                            ),
                            if (hasVoucher) ...[
                              const HorizontalSpacing(8),
                              InkWell(
                                onTap: () {
                                  _voucherController.clear();
                                  checkoutCubit.applyVoucher(null);
                                  cubit.clearVoucher();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                  decoration: BoxDecoration(color: Co.clearRed, borderRadius: BorderRadius.circular(40)),
                                  child: Text(L10n.tr().clear, style: TStyle.robotBlackRegular()),
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ] else ...[
                    const VerticalSpacing(10),
                    BlocBuilder<CheckoutCubit, CheckoutStates>(
                      builder: (context, state) {
                        final checkoutCubit = context.read<CheckoutCubit>();
                        final appliedVoucher = checkoutCubit.voucherCode;
                        final hasVoucher = appliedVoucher != null && appliedVoucher.isNotEmpty;
                        final formKey = GlobalKey<FormState>();
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Form(
                                key: formKey,
                                child: MainTextField(
                                  controller: _voucherController,
                                  borderRadius: 16,
                                  hintText: L10n.tr().enterCode,
                                  validator: Validators.notEmpty,
                                  keyboardType: TextInputType.text,

                                  onChange: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            ),
                            const HorizontalSpacing(10),
                            Expanded(
                              child: BlocConsumer<VouchersCubit, VouchersStates>(
                                listener: (context, state) {
                                  if (state is VoucherApplied) {
                                    Alerts.showToast('${L10n.tr().voucherApplied} ${state.discountAmount}% ${L10n.tr().discount}', error: false);

                                    checkoutCubit.applyVoucher(state.voucherCode);
                                  } else if (state is VoucherError) {
                                    voucherAlert(title: state.message, context: context);
                                  }
                                },
                                builder: (context, state) {
                                  final isLoading = state is VoucherLoading;
                                  return MainBtn(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        return;
                                      }
                                      if (_voucherController.text.trim().isNotEmpty) {
                                        cubit.applyVoucher(_voucherController.text);
                                      }
                                    },
                                    isLoading: isLoading,
                                    text: L10n.tr().apply,
                                    bgColor: _voucherController.text.trim().isEmpty ? Co.grey : Co.secondary,
                                    textStyle: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold, color: Co.purple),
                                  );
                                },
                              ),
                            ),
                            if (hasVoucher) ...[
                              const HorizontalSpacing(8),
                              InkWell(
                                onTap: () {
                                  _voucherController.clear();
                                  checkoutCubit.applyVoucher(null);
                                  cubit.clearVoucher();
                                },
                                child: const Icon(Icons.delete, size: 24, color: Co.red),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
