import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/views/widgets/vendor_widget.dart';
import 'package:intl/intl.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.order,
    this.onReorder,
    this.onViewDetails,
    this.onRatingChanged,
  });

  final OrderItemEntity order;
  final VoidCallback? onReorder;
  final VoidCallback? onViewDetails;
  final Function(double)? onRatingChanged;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd - yyyy');
    final isToday =
        order.orderDate.day == DateTime.now().day && order.orderDate.month == DateTime.now().month && order.orderDate.year == DateTime.now().year;

    return Container(
      margin: const EdgeInsets.all(16),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
                        const VerticalSpacing(4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            isToday ? 'Today ${dateFormat.format(order.orderDate)}' : dateFormat.format(order.orderDate),
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
                            'price',
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
                            'Items',
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
                      child: MainBtn(
                        bgColor: Colors.transparent,
                        borderColor: Colors.transparent,
                        onPressed: () {},
                        child: Text(
                          'View Details',
                          style: TStyle.primaryBold(12).copyWith(
                            decoration: TextDecoration.underline,
                            color: Co.purple,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const VerticalSpacing(12),
                if (order.status == OrderStatus.delivered)
                  SizedBox(
                    width: double.infinity,
                    child: MainBtn(
                      onPressed: onReorder ?? () {},
                      text: 'Reorder',
                      bgColor: Co.purple,
                      radius: 30,
                      textStyle: TStyle.whiteBold(14),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                  ),
              ],
            ),
          ),
          if (order.status == OrderStatus.delivered) ...[
            const VerticalSpacing(12),
            if (order.rating != null)
              _RatingDisplay(rating: order.rating!)
            else if (order.canRate)
              _RatingInput(onRatingChanged: onRatingChanged ?? (_) {}),
          ],
        ],
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        'You Rate ${rating.toInt()}/5 stars',
        style: TStyle.robotBlackMedium(),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _RatingInput extends StatefulWidget {
  const _RatingInput({this.onRatingChanged});

  final Function(double)? onRatingChanged;

  @override
  State<_RatingInput> createState() => _RatingInputState();
}

class _RatingInputState extends State<_RatingInput> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Co.purple100,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Text(
            'Rate',
            style: TStyle.blackRegular(12),
          ),
          const Spacer(),
          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemSize: 24,
            itemPadding: const EdgeInsets.symmetric(horizontal: 2),
            itemBuilder: (context, index) {
              final isRated = index < _rating;
              return Icon(
                isRated ? Icons.star : Icons.star_border,
                color: isRated ? Co.purple : Co.secondary,
              );
            },
            unratedColor: Co.secondary,
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
              widget.onRatingChanged?.call(rating);
            },
          ),
        ],
      ),
    );
  }
}
