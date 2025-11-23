import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_state.dart';

import 'order_issue_response_screen.dart';
import 'widgets/missing_item_tile.dart';

class MissingItemsScreen extends StatefulWidget {
  const MissingItemsScreen({
    super.key,
    required this.orderId,
  });

  final int orderId;

  static const route = '/missing-items';

  @override
  State<MissingItemsScreen> createState() => _MissingItemsScreenState();
}

class _MissingItemsScreenState extends State<MissingItemsScreen> {
  final Set<int> _selectedItemIds = {};
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _toggleItemSelection(int itemId) {
    setState(() {
      if (_selectedItemIds.contains(itemId)) {
        _selectedItemIds.remove(itemId);
      } else {
        _selectedItemIds.add(itemId);
      }
    });
  }

  void _onCheckPressed(BuildContext context, List<OrderDetailItemEntity> allItems) {
    if (_selectedItemIds.isEmpty) {
      // TODO: Show validation message
      return;
    }

    // TODO: Submit the selected items and notes
    // final selectedItems = allItems.where((item) => _selectedItemIds.contains(item.id)).toList();
    // final notes = _notesController.text.trim();

    // Navigate to response screen
    context.navigateToPage(OrderIssueResponseScreen(orderId: widget.orderId));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return BlocProvider(
      create: (context) => OrderDetailCubit(di.get(), widget.orderId)..loadOrderDetail(),
      child: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        builder: (context, state) {
          if (state is OrderDetailLoading && state.orderDetail == null) {
            return Scaffold(
              appBar: MainAppBar(
                title: l10n.missingOrIncorrectItems,
              ),
              body: const Center(
                child: LoadingWidget(),
              ),
            );
          }

          if (state is OrderDetailError) {
            return Scaffold(
              appBar: MainAppBar(
                title: l10n.missingOrIncorrectItems,
              ),
              body: FailureComponent(
                message: state.message,
                onRetry: () {
                  context.read<OrderDetailCubit>().loadOrderDetail();
                },
              ),
            );
          }

          final orderDetail = state is OrderDetailLoaded
              ? state.orderDetail
              : state is OrderDetailLoading
              ? state.orderDetail
              : null;

          if (orderDetail == null) {
            return Scaffold(
              appBar: MainAppBar(
                title: l10n.missingOrIncorrectItems,
              ),
              body: const Center(
                child: LoadingWidget(),
              ),
            );
          }

          // Collect all items from all vendors
          final allItems = orderDetail.vendors.expand((vendor) => vendor.items).toList();

          return Scaffold(
            appBar: MainAppBar(
              title: l10n.missingOrIncorrectItems,
            ),
            body: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.selectMissingIncorrectItems,
                          style: TStyle.robotBlackMedium(),
                        ),
                        const VerticalSpacing(16),
                        ...allItems.map((item) {
                          final isSelected = _selectedItemIds.contains(item.id);
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: MissingItemTile(
                              item: item,
                              isSelected: isSelected,
                              onTap: () => _toggleItemSelection(item.id),
                            ),
                          );
                        }),
                        const VerticalSpacing(16),
                        Text(
                          l10n.addYourNotes,
                          style: TStyle.blackMedium(14),
                        ),
                        const VerticalSpacing(8),
                        MainTextField(
                          controller: _notesController,
                          hintText: l10n.typeYourMessage,
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: MainBtn(
                      onPressed: () => _onCheckPressed(context, allItems),
                      text: l10n.check,
                      width: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
