import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/reorder_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/reorder_state.dart';
import 'package:gazzer/features/orders/views/widgets/order_rating_dialog.dart';
import 'package:gazzer/features/orders/views/widgets/reorder_existing_items_dialog.dart';
import 'package:gazzer/features/orders/views/widgets/vendor_widget.dart';
import 'package:gazzer/features/supportScreen/presentation/views/order_issue_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.order, this.onViewDetails, this.onRatingChanged, this.showGetHelpInsteadOfReorder = false});

  final OrderItemEntity order;
  final VoidCallback? onViewDetails;
  final Function(double)? onRatingChanged;
  final bool showGetHelpInsteadOfReorder;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd - yyyy');
    final isToday =
        order.orderDate.day == DateTime.now().day && order.orderDate.month == DateTime.now().month && order.orderDate.year == DateTime.now().year;

    return InkWell(
      onTap: () {
        onViewDetails?.call();
      },
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Co.bg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Co.lightGrey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: VendorWidget(vendors: order.vendors, selectedVendorId: order.primaryVendor.id, orderId: order.orderId),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(color: order.status.badgeColor, borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              order.status.label,
                              style: context.style14400
                                  .copyWith(fontWeight: TStyle.bold, color: _getStatusTextColor(order.status))
                                  .copyWith(color: _getStatusTextColor(order.status)),
                            ),
                          ),
                          const VerticalSpacing(6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              isToday ? '${L10n.tr().today} ${dateFormat.format(order.orderDate)}' : dateFormat.format(order.orderDate),
                              style: TStyle.robotBlackThin(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const VerticalSpacing(12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(L10n.tr().price, style: context.style16400),
                            Text(Helpers.getProperPrice(order.price), style: TStyle.robotBlackMedium()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(L10n.tr().items, style: context.style16400),
                            Text('${order.itemsCount}', style: TStyle.robotBlackMedium()),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          L10n.tr().viewDetails,
                          style: TStyle.robotBlackMedium().copyWith(decoration: TextDecoration.underline, color: Co.purple),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  if (order.status == OrderStatus.delivered) ...[
                    const VerticalSpacing(12),
                    _ReorderButton(order: order, showGetHelp: showGetHelpInsteadOfReorder),
                  ],
                  if (order.status != OrderStatus.delivered && order.status != OrderStatus.cancelled) ...[
                    const VerticalSpacing(12),
                    MainBtn(
                      onPressed: () {
                        onViewDetails?.call();
                      },
                      width: double.infinity,
                      text: L10n.tr().trackOrder,
                      bgColor: Co.purple,
                      radius: 30,
                      textStyle: context.style14400.copyWith(color: Co.white),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ],
              ),
            ),
            if (order.status == OrderStatus.delivered) ...[
              const VerticalSpacing(12),
              if (order.canRate)
                _RatingDisplay(rating: order.rating!.toDouble())
              else
                _RatingInput(
                  orderId: int.tryParse(order.orderId) ?? 0,
                  vendors: order.vendors,
                  deliveryManId: order.deliveryManId ?? 0,
                  onRatingChanged: onRatingChanged ?? (_) {},
                ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusTextColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return const Color(0xFF2E7D32); // Dark green
      case OrderStatus.cancelled:
        return const Color(0xFFD32F2F); // Dark red
      case OrderStatus.preparing:
        return const Color(0xFFF57C00); // Dark orange
      case OrderStatus.pending:
        return const Color(0xFF1976D2); // Dark blue
    }
  }
}

class _RatingDisplay extends StatelessWidget {
  const _RatingDisplay({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Co.lightPurple,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(L10n.tr().you_rate_stars(rating), style: TStyle.robotBlackMedium(), textAlign: TextAlign.center),
    );
  }
}

class _RatingInput extends StatelessWidget {
  const _RatingInput({required this.orderId, required this.vendors, required this.deliveryManId, this.onRatingChanged});

  final int orderId;
  final List<OrderVendorEntity> vendors;
  final int deliveryManId;
  final Function(double)? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => OrderRatingDialog(orderId: orderId, vendors: vendors, deliveryManId: deliveryManId),
        );
        await context.read<OrdersCubit>().loadOrders(refresh: true);

        if (result == true && onRatingChanged != null) {
          // Call callback after successful rating
          onRatingChanged!(5.0); // Default rating after submission
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Co.lightPurple,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(L10n.tr().rateUs, style: context.style14400),
            const Spacer(),
            ...List.generate(
              5,
              (index) => Padding(padding: const EdgeInsets.symmetric(horizontal: 4.0), child: SvgPicture.asset(Assets.starNotRateIc)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReorderButton extends StatelessWidget {
  const _ReorderButton({required this.order, this.showGetHelp = false});

  final OrderItemEntity order;
  final bool showGetHelp;

  @override
  Widget build(BuildContext context) {
    final orderId = int.tryParse(order.orderId) ?? 0;

    // Show Get Help button instead of Reorder
    if (showGetHelp) {
      return SizedBox(
        width: double.infinity,
        child: MainBtn(
          onPressed: () {
            context.push(OrderIssueScreen.route, extra: orderId);
          },
          bgColor: Co.purple,
          radius: 30,
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Assets.customerSupportIc),
              const HorizontalSpacing(10),
              Text(L10n.tr().getHelp, style: context.style14400.copyWith(color: Co.white)),
            ],
          ),
        ),
      );
    }

    // Original Reorder button functionality
    return BlocProvider(
      create: (context) => ReorderCubit(di.get()),
      child: BlocConsumer<ReorderCubit, ReorderState>(
        listener: (context, reorderState) async {
          if (reorderState is ReorderSuccess) {
            Alerts.showToast(reorderState.message, error: false);
            // Reload cart to reflect the reordered items
            if (context.mounted) {
              context.read<CartCubit>().loadCart();
            }
            // Navigate to cart screen
            if (context.mounted) {
              context.push(CartScreen.route);
            }
          } else if (reorderState is ReorderHasExistingItems) {
            // Check if hasExistingItem is true (not null/false)
            if (reorderState.hasExistingItem) {
              // Type 1: Has existing items - show dialog for existing items
              final keepExisting = await showReorderExistingItemsDialog(
                context: context,
                existingItemsCount: reorderState.hasExistingItem,
                addNewPouchApproval: reorderState.addNewPouchApproval,
                message: reorderState.detailedMessage,
              );

              if (context.mounted && keepExisting != null) {
                // User chose: true = keep existing items, false = clear existing items
                context.read<ReorderCubit>().continueReorder(keepExisting);
              }
            } else {
              // Type 2: hasExistingItem is false/null - check on addNewPouch
              if (!reorderState.addNewPouchApproval) {
                // addNewPouch is false/null - show error
                Alerts.showToast(reorderState.message);
              } else {
                // addNewPouch is true - show dialog and send as key with re-order API
                final keepExisting = await showReorderExistingItemsDialog(
                  context: context,
                  existingItemsCount: reorderState.hasExistingItem,
                  addNewPouchApproval: reorderState.addNewPouchApproval,
                  message: reorderState.detailedMessage,
                );

                if (context.mounted && keepExisting != null) {
                  // Send both keepExisting and addNewPouch as keys with re-order API
                  context.read<ReorderCubit>().continueReorder(keepExisting, addNewPouch: reorderState.addNewPouchApproval);
                }
              }
            }
          } else if (reorderState is ReorderErrorState) {
            Alerts.showToast(reorderState.message);
          }
        },
        builder: (context, reorderState) {
          final isLoading = reorderState is ReorderLoading && reorderState.orderId == orderId;

          return SizedBox(
            width: double.infinity,
            child: MainBtn(
              onPressed: isLoading
                  ? () {}
                  : () {
                      context.read<ReorderCubit>().reorder(orderId);
                    },
              text: L10n.tr().reOrder,
              bgColor: isLoading ? Co.purple.withOpacityNew(0.5) : Co.purple,
              radius: 30,
              textStyle: context.style14400.copyWith(color: Co.white),
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
          );
        },
      ),
    );
  }
}

/// Compact active order card widget for home screen
/// Shows different layouts based on estimated time:
/// - Time < 5 minutes: Shows map snippet (first image style)
/// - Time >= 5 minutes: Regular card without map (second image style)
class ActiveOrderCardWidget extends StatelessWidget {
  const ActiveOrderCardWidget({super.key, required this.order, this.estimatedTimeMinutes, this.onViewDetails, this.onTrackOrder});

  final OrderItemEntity order;
  final int? estimatedTimeMinutes; // Estimated time in minutes (null if not available)
  final VoidCallback? onViewDetails;
  final VoidCallback? onTrackOrder;

  /// Determines if the order should show map snippet (time < 5 minutes)
  bool get _showMapSnippet => estimatedTimeMinutes != null && estimatedTimeMinutes! < 5;

  /// Formats time estimate as "X - Y Min"
  String _formatTimeEstimate() {
    if (estimatedTimeMinutes == null) {
      return '${L10n.tr().time}: --';
    }
    // For orders with time < 5, show "5 - 10 Min"
    if (estimatedTimeMinutes! < 5) {
      return '${L10n.tr().time}: $estimatedTimeMinutes ${L10n.tr().min}';
    }
    // For orders with time >= 5, show "20 - 30 Min" or similar
    final minTime = estimatedTimeMinutes!;
    final maxTime = estimatedTimeMinutes! + 10;
    return '${L10n.tr().time}: $minTime - $maxTime ${L10n.tr().min}';
  }

  @override
  Widget build(BuildContext context) {
    if (_showMapSnippet) {
      return _ActiveOrderCardWithMap(order: order, timeEstimate: _formatTimeEstimate(), onViewDetails: onViewDetails, onTrackOrder: onTrackOrder);
    } else {
      return _ActiveOrderCardWithoutMap(order: order, timeEstimate: _formatTimeEstimate(), onViewDetails: onViewDetails, onTrackOrder: onTrackOrder);
    }
  }
}

/// Active order card with map snippet (for orders with time < 5 minutes)
class _ActiveOrderCardWithMap extends StatelessWidget {
  const _ActiveOrderCardWithMap({required this.order, required this.timeEstimate, this.onViewDetails, this.onTrackOrder});

  final OrderItemEntity order;
  final String timeEstimate;
  final VoidCallback? onViewDetails;
  final VoidCallback? onTrackOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Vendor info and status row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: VendorWidget(vendors: order.vendors, selectedVendorId: order.primaryVendor.id, orderId: order.orderId),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(color: order.status.badgeColor, borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            order.status.label,
                            style: context.style14400
                                .copyWith(fontWeight: TStyle.bold, color: _getStatusTextColor(order.status))
                                .copyWith(color: _getStatusTextColor(order.status)),
                          ),
                        ),
                        const VerticalSpacing(6),
                        Text(timeEstimate, style: TStyle.robotBlackThin()),
                      ],
                    ),
                  ],
                ),
                const VerticalSpacing(16),
                // Price, Items, View Details, and Map row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left side: Price, Items, View Details
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(L10n.tr().price, style: context.style16400),
                                    Text(Helpers.getProperPrice(order.price), style: TStyle.robotBlackMedium()),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(L10n.tr().items, style: context.style16400),
                                    Text('${order.itemsCount}', style: TStyle.robotBlackMedium()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpacing(8),
                          InkWell(
                            onTap: onViewDetails,
                            child: Text(
                              L10n.tr().viewDetails,
                              style: TStyle.robotBlackMedium().copyWith(
                                decoration: TextDecoration.underline,
                                color: Co.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const HorizontalSpacing(12),
                    // Right side: Map snippet
                    Image.asset(Assets.trackMapIc),
                  ],
                ),
                const VerticalSpacing(16),
                // Track order button
                MainBtn(
                  onPressed: onTrackOrder ?? () => onViewDetails?.call(),
                  width: double.infinity,
                  text: L10n.tr().trackOrder,
                  bgColor: Co.purple,
                  radius: 30,
                  textStyle: context.style14400.copyWith(color: Co.white),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusTextColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return const Color(0xFF2E7D32);
      case OrderStatus.cancelled:
        return const Color(0xFFD32F2F);
      case OrderStatus.preparing:
        return const Color(0xFFF57C00);
      case OrderStatus.pending:
        return const Color(0xFF1976D2);
    }
  }
}

/// Active order card without map (for orders with time >= 5 minutes)
class _ActiveOrderCardWithoutMap extends StatelessWidget {
  const _ActiveOrderCardWithoutMap({required this.order, required this.timeEstimate, this.onViewDetails, this.onTrackOrder});

  final OrderItemEntity order;
  final String timeEstimate;
  final VoidCallback? onViewDetails;
  final VoidCallback? onTrackOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Co.bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vendor info and status row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: VendorWidget(vendors: order.vendors, selectedVendorId: order.primaryVendor.id, orderId: order.orderId),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(color: order.status.badgeColor, borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        order.status.label,
                        style: context.style14400
                            .copyWith(fontWeight: TStyle.bold, color: _getStatusTextColor(order.status))
                            .copyWith(color: _getStatusTextColor(order.status)),
                      ),
                    ),
                    const VerticalSpacing(6),
                    Text(timeEstimate, style: TStyle.robotBlackThin()),
                  ],
                ),
              ],
            ),
            const VerticalSpacing(16),
            // Price, Items, View Details row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(L10n.tr().price, style: context.style16400),
                      Text(Helpers.getProperPrice(order.price), style: TStyle.robotBlackMedium()),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(L10n.tr().items, style: context.style16400),
                      Text('${order.itemsCount}', style: TStyle.robotBlackMedium()),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onViewDetails,
                    child: Text(
                      L10n.tr().viewDetails,
                      style: TStyle.robotBlackMedium().copyWith(decoration: TextDecoration.underline, color: Co.purple, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            const VerticalSpacing(16),
            // Track order button
            MainBtn(
              onPressed: onTrackOrder ?? () => onViewDetails?.call(),
              width: double.infinity,
              text: L10n.tr().trackOrder,
              bgColor: Co.purple,
              radius: 30,
              textStyle: context.style14400.copyWith(color: Co.white),
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusTextColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.delivered:
        return const Color(0xFF2E7D32);
      case OrderStatus.cancelled:
        return const Color(0xFFD32F2F);
      case OrderStatus.preparing:
        return const Color(0xFFF57C00);
      case OrderStatus.pending:
        return const Color(0xFF1976D2);
    }
  }
}
