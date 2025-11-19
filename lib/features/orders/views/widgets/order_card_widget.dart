import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
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
import 'package:gazzer/features/orders/presentation/cubit/reorder_cubit.dart';
import 'package:gazzer/features/orders/presentation/cubit/reorder_state.dart';
import 'package:gazzer/features/orders/views/widgets/order_rating_dialog.dart';
import 'package:gazzer/features/orders/views/widgets/reorder_existing_items_dialog.dart';
import 'package:gazzer/features/orders/views/widgets/vendor_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.order,
    this.onViewDetails,
    this.onRatingChanged,
  });

  final OrderItemEntity order;
  final VoidCallback? onViewDetails;
  final Function(double)? onRatingChanged;

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
          border: Border.all(color: Co.lightGrey.withOpacityNew(0.3)),
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
                        child: VendorWidget(
                          vendors: order.vendors,
                          selectedVendorId: order.primaryVendor.id,
                          orderId: order.orderId,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: order.status.badgeColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              order.status.label,
                              style: TStyle.blackBold(12).copyWith(
                                color: _getStatusTextColor(order.status),
                              ),
                            ),
                          ),
                          const VerticalSpacing(6),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              isToday ? '${L10n.tr().today} ${dateFormat.format(order.orderDate)}' : dateFormat.format(order.orderDate),
                              style: TStyle.blackRegular(12),
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
                            Text(
                              L10n.tr().price,
                              style: TStyle.robotBlackRegular(),
                            ),
                            Text(
                              Helpers.getProperPrice(order.price),
                              style: TStyle.robotBlackMedium(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              L10n.tr().items,
                              style: TStyle.robotBlackRegular(),
                            ),
                            Text(
                              '${order.itemsCount}',
                              style: TStyle.robotBlackMedium(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          L10n.tr().viewDetails,
                          style: TStyle.robotBlackRegular().copyWith(
                            decoration: TextDecoration.underline,
                            color: Co.purple,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  if (order.status == OrderStatus.delivered) ...[
                    const VerticalSpacing(12),
                    _ReorderButton(order: order),
                  ],
                ],
              ),
            ),
            if (order.status == OrderStatus.delivered) ...[
              const VerticalSpacing(12),
              if (order.rating != null)
                _RatingDisplay(rating: order.rating!.toDouble())
              else if (order.canRate)
                _RatingInput(
                  orderId: int.tryParse(order.orderId) ?? 0,
                  vendors: order.vendors,
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
        color: Co.purple100,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        L10n.tr().you_rate_stars(rating),
        style: TStyle.robotBlackMedium(),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RatingInput extends StatelessWidget {
  const _RatingInput({
    required this.orderId,
    required this.vendors,
    this.onRatingChanged,
  });

  final int orderId;
  final List<OrderVendorEntity> vendors;
  final Function(double)? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => OrderRatingDialog(
            orderId: orderId,
            vendors: vendors,
          ),
        );
        if (result == true && onRatingChanged != null) {
          // Call callback after successful rating
          onRatingChanged!(5.0); // Default rating after submission
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Co.purple100,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Text(
              L10n.tr().rateUs,
              style: TStyle.blackRegular(12),
            ),
            const Spacer(),
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SvgPicture.asset(Assets.starNotRateIc),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReorderButton extends StatelessWidget {
  const _ReorderButton({required this.order});

  final OrderItemEntity order;

  @override
  Widget build(BuildContext context) {
    final orderId = int.tryParse(order.orderId) ?? 0;

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
            // Show dialog asking user if they want to keep or clear existing items
            final keepExisting = await showReorderExistingItemsDialog(
              context: context,
              existingItemsCount: reorderState.existingItemsCount,
              message: reorderState.detailedMessage,
            );

            if (context.mounted && keepExisting != null) {
              // User chose: true = keep existing items, false = clear existing items
              context.read<ReorderCubit>().continueReorder(
                keepExisting,
              );
            }
          } else if (reorderState is ReorderErrorState) {
            Alerts.showToast(reorderState.message, error: true);
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
              textStyle: TStyle.whiteBold(14),
              padding: const EdgeInsets.symmetric(vertical: 5),
            ),
          );
        },
      ),
    );
  }
}
