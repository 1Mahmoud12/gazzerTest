import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_state.dart';
import 'package:gazzer/features/supportScreen/data/requests/complaint_request.dart';
import 'package:gazzer/features/supportScreen/domain/entities/enums_support.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/complaint_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/complaint_states.dart';

import '../gazzer_support_screen.dart';
import '../order_issue_response_screen.dart';
import '../widgets/missing_item_tile.dart';

class MissingItemsScreen extends StatefulWidget {
  const MissingItemsScreen({super.key, required this.orderId, this.faqCategoryId});

  final int orderId;
  final int? faqCategoryId;

  static const route = '/missing-items';

  @override
  State<MissingItemsScreen> createState() => _MissingItemsScreenState();
}

class _MissingItemsScreenState extends State<MissingItemsScreen> {
  final Map<int, int> _selectedItemsWithQuantity = {}; // itemId -> quantity
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _toggleItemSelection(int itemId, int maxQuantity) {
    setState(() {
      if (_selectedItemsWithQuantity.containsKey(itemId)) {
        _selectedItemsWithQuantity.remove(itemId);
      } else {
        _selectedItemsWithQuantity[itemId] = 1;
      }
    });
  }

  void _updateItemQuantity(int itemId, int quantity, int maxQuantity) {
    setState(() {
      if (quantity <= 0) {
        _selectedItemsWithQuantity.remove(itemId);
      } else if (quantity > maxQuantity) {
        _selectedItemsWithQuantity[itemId] = maxQuantity;
      } else {
        _selectedItemsWithQuantity[itemId] = quantity;
      }
    });
  }

  int _getItemQuantity(int itemId) {
    return _selectedItemsWithQuantity[itemId] ?? 0;
  }

  bool _isItemSelected(int itemId) {
    return _selectedItemsWithQuantity.containsKey(itemId) && _selectedItemsWithQuantity[itemId]! > 0;
  }

  void _onCheckPressed(BuildContext context, OrderDetailEntity orderDetail) {
    if (_selectedItemsWithQuantity.isEmpty) {
      Alerts.showToast(L10n.tr().youMustCheckOneAtLeast);
      return;
    }

    // Check if order is more than 24 hours old
    final now = DateTime.now();
    final orderDate = orderDetail.orderDate;
    final hoursSinceOrder = now.difference(orderDate).inHours;

    // Calculate total value of selected items
    final allItems = orderDetail.vendors.expand((vendor) => vendor.items).toList();
    double selectedItemsTotal = 0.0;
    for (final entry in _selectedItemsWithQuantity.entries) {
      final itemId = entry.key;
      final quantity = entry.value;
      final item = allItems.firstWhere((item) => item.id == itemId);
      selectedItemsTotal += item.price * quantity;
    }
    // Check if selected items total is less than delivery fee
    if ((hoursSinceOrder > 24) && (selectedItemsTotal < orderDetail.deliveryFee)) {
      // Navigate to support screen
      context.navigateToPage(GazzerSupportScreen(orderId: widget.orderId));
      return;
    }

    // Submit the complaint
    final selectedItemIds = _selectedItemsWithQuantity.keys.toList();
    final selectedItemQuantities = selectedItemIds.map((id) => _selectedItemsWithQuantity[id]!).toList();
    final notes = _notesController.text.trim();

    final request = ComplaintRequest(
      orderId: widget.orderId,
      orderItemIds: selectedItemIds,
      orderItemCounts: selectedItemQuantities,
      note: notes.isEmpty ? null : notes,
      type: ComplaintType.missingItems,
    );

    context.read<ComplaintCubit>().submitComplaint(request);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderDetailCubit(di.get(), widget.orderId)..loadOrderDetail()),
        BlocProvider(create: (context) => ComplaintCubit(di.get())),
      ],
      child: BlocConsumer<ComplaintCubit, ComplaintStates>(
        listener: (context, complaintState) {
          if (complaintState is ComplaintSuccessState) {
            // Navigate to response screen after successful submission
            context.navigateToPage(OrderIssueResponseScreen(orderId: widget.orderId, faqCategoryId: widget.faqCategoryId));
          }
        },
        builder: (context, complaintState) {
          return BlocBuilder<OrderDetailCubit, OrderDetailState>(
            builder: (context, state) {
              if (state is OrderDetailLoading && state.orderDetail == null) {
                return Scaffold(
                  appBar: MainAppBar(title: l10n.missingOrIncorrectItems),
                  body: const Center(child: LoadingWidget()),
                );
              }

              if (state is OrderDetailError) {
                return Scaffold(
                  appBar: MainAppBar(title: l10n.missingOrIncorrectItems),
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
                  appBar: MainAppBar(title: l10n.missingOrIncorrectItems),
                  body: const Center(child: LoadingWidget()),
                );
              }

              return Scaffold(
                appBar: MainAppBar(title: l10n.missingOrIncorrectItems),
                body: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(l10n.selectMissingIncorrectItems, style: TStyle.robotBlackMedium()),
                            const VerticalSpacing(16),
                            ..._buildItemSections(orderDetail),
                            const VerticalSpacing(16),
                            Text(l10n.addYourNotes, style: TStyle.blackMedium(14)),
                            const VerticalSpacing(8),
                            MainTextField(controller: _notesController, hintText: l10n.typeYourMessage, maxLines: 5),
                          ],
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: MainBtn(onPressed: () => _onCheckPressed(context, orderDetail), text: l10n.check, width: double.infinity),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  List<Widget> _buildItemSections(OrderDetailEntity orderDetail) {
    return orderDetail.vendors.map((vendorDetail) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Vendor header
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                if (vendorDetail.vendor.logo != null || vendorDetail.vendor.image != null)
                  ClipOval(child: CustomNetworkImage(vendorDetail.vendor.logo ?? vendorDetail.vendor.image ?? '', width: 40, height: 40))
                else
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: Co.secondary, borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        vendorDetail.vendor.name.isNotEmpty ? vendorDetail.vendor.name.substring(0, 1).toUpperCase() : 'V',
                        style: TStyle.blackBold(16),
                      ),
                    ),
                  ),
                const HorizontalSpacing(12),
                Expanded(child: Text(vendorDetail.vendor.name, style: TStyle.blackBold(16))),
              ],
            ),
          ),
          // Items for this vendor
          ...vendorDetail.items.map((item) {
            final isSelected = _isItemSelected(item.id);
            final quantity = _getItemQuantity(item.id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: MissingItemTile(
                item: item,
                isSelected: isSelected,
                quantity: quantity,
                onTap: () => _toggleItemSelection(item.id, item.quantity),
                onQuantityChanged: (newQuantity) => _updateItemQuantity(item.id, newQuantity, item.quantity),
              ),
            );
          }),
          const VerticalSpacing(8),
        ],
      );
    }).toList();
  }
}
