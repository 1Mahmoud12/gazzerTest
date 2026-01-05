import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_summary_entity.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/delivery_tracking_map_widget.dart';

/// Order summary section displaying pricing breakdown
class OrderSummarySection extends StatelessWidget {
  const OrderSummarySection({super.key, required this.orderDetail});

  final OrderDetailEntity orderDetail;

  static const double _padding = 16.0;
  static const double _borderRadius = 12.0;
  static const double _itemSpacing = 8.0;
  static const double _finalSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    final summary = orderDetail.orderSummary;
    final finalTotal = summary != null ? summary.totalPaidAmount : _calculateFinalTotal();
    final voucherFormatted = _getVoucherFormatted(summary);
    final isNotDelivered = orderDetail.status != OrderStatus.delivered && orderDetail.status != OrderStatus.cancelled;

    // If not delivered, show the new layout from image
    if (isNotDelivered) {
      return _buildNotDeliveredLayout(context, summary, finalTotal, voucherFormatted);
    }

    // Original layout for delivered/cancelled orders
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(L10n.tr().orderSummary, style: TStyle.robotBlackTitle()),
            InkWell(
              onTap: () => Alerts.showToast(L10n.tr().comingSoon, error: false),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text(
                L10n.tr().viewReceipt,
                style: TStyle.robotBlackRegular().copyWith(color: Co.purple, decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
        const VerticalSpacing(10),
        Container(
          padding: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(_borderRadius), color: Co.purple100),
          child: Column(
            children: [
              // Sub Total
              if ((summary?.subTotal ?? orderDetail.subTotal) != 0) ...[
                OrderSummaryItem(title: L10n.tr().grossAmount, value: summary?.subTotal ?? orderDetail.subTotal),
                const SizedBox(height: _itemSpacing),
              ],
              // Item Discount
              if ((summary?.itemDiscount ?? 0.0) != 0) ...[
                OrderSummaryItem(title: L10n.tr().discount, value: summary!.itemDiscount, isDiscount: true),
                const SizedBox(height: _itemSpacing),
              ],
              // VAT Amount
              if ((summary?.vatAmount ?? 0.0) != 0) ...[
                OrderSummaryItem(title: 'VAT', value: summary!.vatAmount),
                const SizedBox(height: _itemSpacing),
              ],
              // Service Fees
              if ((summary?.serviceFees ?? orderDetail.serviceFee) != 0) ...[
                OrderSummaryItem(title: L10n.tr().serviceFee, value: summary?.serviceFees ?? orderDetail.serviceFee),
                const SizedBox(height: _itemSpacing),
              ],
              // // Coupon Code (if exists)
              // if (summary?.coupon != null && summary!.coupon!.isNotEmpty) ...[
              //   OrderSummaryItem(
              //     title: L10n.tr().promoCodeName,
              //     value: summary.coupon!,
              //   ),
              //   const SizedBox(height: _itemSpacing),
              // ],
              // Coupon Discount
              if ((summary?.couponDiscount ?? 0.0) != 0) ...[
                OrderSummaryItem(title: L10n.tr().promoCode, value: summary!.couponDiscount, isDiscount: true, formattedValue: voucherFormatted),
                const SizedBox(height: _itemSpacing),
              ],
              // Delivery Fees
              if ((summary?.deliveryFees ?? orderDetail.deliveryFee) != 0) ...[
                OrderSummaryItem(title: L10n.tr().deliveryFee, value: summary?.deliveryFees ?? orderDetail.deliveryFee),
                const SizedBox(height: _itemSpacing),
              ],
              // Delivery Fees Discount
              if ((summary?.deliveryFeesDiscount ?? 0.0) != 0) ...[
                OrderSummaryItem(title: L10n.tr().deliveryFeeDiscount, value: summary!.deliveryFeesDiscount, isDiscount: true),
                const SizedBox(height: _itemSpacing),
              ],
              const DashedBorder(width: 10, gap: 8, color: Co.gryPrimary, thickness: 1.5),
              const VerticalSpacing(_finalSpacing),
              FinalTotalRow(total: finalTotal),
              OrderSummaryItem(title: L10n.tr().paymentMethod, value: summary?.paymentMethod ?? orderDetail.paymentMethod),
            ],
          ),
        ),
      ],
    );
  }

  double _calculateFinalTotal() {
    final baseTotal = orderDetail.total;
    final voucherDeduction = _getVoucherDeduction();
    return (baseTotal - voucherDeduction).clamp(0.0, double.infinity);
  }

  double _getVoucherDeduction() {
    if (orderDetail.voucherCode == null ||
        orderDetail.voucherDiscountType == null ||
        orderDetail.voucherDiscountAmount == null ||
        orderDetail.voucherDiscountAmount! <= 0) {
      return 0.0;
    }

    final isPercent = orderDetail.voucherDiscountType!.toLowerCase().contains('percent');
    if (isPercent) {
      return orderDetail.total * (orderDetail.voucherDiscountAmount! / 100.0);
    } else {
      return orderDetail.voucherDiscountAmount!;
    }
  }

  String? _getVoucherFormatted(OrderSummaryEntity? summary) {
    // Use summary coupon if available
    if (summary?.coupon != null && summary!.couponDiscount > 0) {
      return '- ${Helpers.getProperPrice(summary.couponDiscount)}';
    }

    // Fallback to orderDetail voucher
    if (orderDetail.voucherCode == null ||
        orderDetail.voucherDiscountType == null ||
        orderDetail.voucherDiscountAmount == null ||
        orderDetail.voucherDiscountAmount! <= 0) {
      return null;
    }

    return '- ${Helpers.getProperPrice(orderDetail.voucherDiscountAmount!)}';
  }

  /// Build layout for non-delivered orders (matching the image)
  Widget _buildNotDeliveredLayout(BuildContext context, OrderSummaryEntity? summary, double finalTotal, String? voucherFormatted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top section: Total (Paid Amount) and Payment method
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${L10n.tr().total} (${L10n.tr().amountToPay})', style: TStyle.robotBlackRegular()),
            Text(Helpers.getProperPrice(finalTotal), style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
          ],
        ),
        const VerticalSpacing(12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(L10n.tr().paymentMethod, style: TStyle.robotBlackRegular()),
            Text(summary?.paymentMethod ?? orderDetail.paymentMethod, style: TStyle.robotBlackRegular()),
          ],
        ),
        const VerticalSpacing(16),
        // Collapsible Order Summary Card
        _CollapsibleOrderSummaryCard(orderDetail: orderDetail, summary: summary, voucherFormatted: voucherFormatted),
        const VerticalSpacing(16),
        // Delivery Man Section
        _DeliveryManSection(),
        const VerticalSpacing(16),
        // Map and Delivery Arrival Time
        _DeliveryMapAndTimeSection(orderId: orderDetail.orderId, deliveryTimeMinutes: orderDetail.deliveryTimeMinutes),
      ],
    );
  }
}

class OrderSummaryItem extends StatelessWidget {
  const OrderSummaryItem({super.key, required this.title, required this.value, this.isDiscount = false, this.formattedValue});

  final String title;
  final dynamic value;
  final bool isDiscount;
  final String? formattedValue;

  @override
  Widget build(BuildContext context) {
    final valueText = value is String ? value : formattedValue ?? '${isDiscount && value != 0 ? '-' : ''} ${Helpers.getProperPrice(value)}';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TStyle.blackSemi(16, font: FFamily.roboto)),
        Text(valueText, style: TStyle.blackSemi(18, font: FFamily.roboto)),
      ],
    );
  }
}

class FinalTotalRow extends StatelessWidget {
  const FinalTotalRow({super.key, required this.total});

  final double total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  L10n.tr().total,
                  style: TStyle.blackSemi(20, font: FFamily.roboto),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const HorizontalSpacing(2),
              Text(
                ' (${L10n.tr().amountToPay}) ',
                style: TStyle.blackBold(12, font: FFamily.roboto).copyWith(overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
            ],
          ),
        ),
        const HorizontalSpacing(12),
        Text(Helpers.getProperPrice(total), style: TStyle.burbleSemi(20, font: FFamily.roboto)),
      ],
    );
  }
}

/// Collapsible Order Summary Card
class _CollapsibleOrderSummaryCard extends StatefulWidget {
  const _CollapsibleOrderSummaryCard({required this.orderDetail, this.summary, this.voucherFormatted});

  final OrderDetailEntity orderDetail;
  final OrderSummaryEntity? summary;
  final String? voucherFormatted;

  @override
  State<_CollapsibleOrderSummaryCard> createState() => _CollapsibleOrderSummaryCardState();
}

class _CollapsibleOrderSummaryCardState extends State<_CollapsibleOrderSummaryCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Co.lightGrey.withOpacityNew(0.3)),
      child: Column(
        children: [
          // Header with title and chevron
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Summery', style: TStyle.robotBlackMedium()),
                  Icon(_isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Co.purple),
                ],
              ),
            ),
          ),
          if (_isExpanded) ...[
            // Dashed border separator
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: DashedBorder(width: double.infinity, gap: 8, color: Co.purple, thickness: 1.5),
            ),
            const VerticalSpacing(16),
            // Summary items
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  _buildSummaryItem('Sub total', widget.summary?.subTotal ?? widget.orderDetail.subTotal),
                  if ((widget.summary?.itemDiscount ?? 0.0) != 0) _buildSummaryItem('Item Discount', widget.summary!.itemDiscount, isDiscount: true),
                  if ((widget.summary?.vatAmount ?? 0.0) != 0) _buildSummaryItem('Vat Amount', widget.summary!.vatAmount),
                  if ((widget.summary?.serviceFees ?? widget.orderDetail.serviceFee) != 0)
                    _buildSummaryItem('Service fees', widget.summary?.serviceFees ?? widget.orderDetail.serviceFee),
                  if (widget.summary?.coupon != null && widget.summary!.coupon!.isNotEmpty)
                    _buildSummaryItem('Coupon', widget.summary!.coupon!, isText: true),
                  if ((widget.summary?.couponDiscount ?? 0.0) != 0)
                    _buildSummaryItem('Coupon Discount', widget.summary!.couponDiscount, isDiscount: true),
                  if ((widget.summary?.deliveryFees ?? widget.orderDetail.deliveryFee) != 0)
                    _buildSummaryItem('Delivery Fees', widget.summary?.deliveryFees ?? widget.orderDetail.deliveryFee),
                  if ((widget.summary?.deliveryFeesDiscount ?? 0.0) != 0)
                    _buildSummaryItem('Delivery Fees Discount', widget.summary!.deliveryFeesDiscount, isDiscount: true),
                ],
              ),
            ),
            const VerticalSpacing(16),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String title, dynamic value, {bool isDiscount = false, bool isText = false}) {
    final valueText = isText ? value.toString() : '${isDiscount && value != 0 ? '-' : ''} ${Helpers.getProperPrice(value)}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TStyle.robotBlackRegular()),
          Text(valueText, style: TStyle.robotBlackRegular()),
        ],
      ),
    );
  }
}

/// Delivery Man Section
class _DeliveryManSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: Replace with actual delivery man data from orderDetail
    final deliveryManName = 'Ahmed Ali'; // Placeholder

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), color: Co.purple100),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(L10n.tr().your_delivery_man, style: TStyle.robotBlackRegular().copyWith(color: Co.darkGrey)),
                const VerticalSpacing(4),
                Text(deliveryManName, style: TStyle.robotBlackMedium()),
              ],
            ),
          ),
          // // Chat button (yellow)
          // Container(
          //   width: 40,
          //   height: 40,
          //   decoration: const BoxDecoration(color: Co.secondary, shape: BoxShape.circle),
          //   child: IconButton(
          //     icon: const VectorGraphicsWidget(Assets.assetsSvgChat),
          //     onPressed: () {
          //       // TODO: Implement chat functionality
          //       Alerts.showToast('Chat with delivery man', error: false);
          //     },
          //     padding: EdgeInsets.zero,
          //   ),
          // ),
          // const HorizontalSpacing(12),
          // Phone button (purple)
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(color: Co.purple, shape: BoxShape.circle),
            child: IconButton(
              icon: const VectorGraphicsWidget(Assets.phoneIc, colorFilter: ColorFilter.mode(Co.white, BlendMode.srcIn)),
              onPressed: () {
                // TODO: Implement call functionality
                Alerts.showToast('Call delivery man', error: false);
              },
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

/// Delivery Map and Time Section
class _DeliveryMapAndTimeSection extends StatelessWidget {
  const _DeliveryMapAndTimeSection({required this.orderId, this.deliveryTimeMinutes});

  final int orderId;
  final int? deliveryTimeMinutes;

  @override
  Widget build(BuildContext context) {
    // Use the new DeliveryTrackingMapWidget with static coordinates
    return DeliveryTrackingMapWidget(
      orderId: orderId,
      deliveryTimeMinutes: deliveryTimeMinutes,
      // Static coordinates will be used by default if not provided
      // userLocation: LatLng(30.0444, 31.2357),
      // deliveryLocation: LatLng(30.0811, 31.2487),
      // roadDistance: 1.5,
    );
  }
}
