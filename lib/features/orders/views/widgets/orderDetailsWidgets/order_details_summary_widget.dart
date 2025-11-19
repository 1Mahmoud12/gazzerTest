import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_summary_entity.dart';

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

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              L10n.tr().orderSummary,
              style: TStyle.robotBlackTitle(),
            ),
            InkWell(
              onTap: () => Alerts.showToast(L10n.tr().comingSoon, error: false),
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              child: Text(
                L10n.tr().viewReceipt,
                style: TStyle.robotBlackRegular().copyWith(
                  color: Co.purple,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
        const VerticalSpacing(10),
        Container(
          padding: const EdgeInsets.all(_padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_borderRadius),
            color: Co.purple100,
          ),
          child: Column(
            children: [
              // Sub Total
              if ((summary?.subTotal ?? orderDetail.subTotal) != 0) ...[
                OrderSummaryItem(
                  title: L10n.tr().grossAmount,
                  value: summary?.subTotal ?? orderDetail.subTotal,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // Item Discount
              if ((summary?.itemDiscount ?? 0.0) != 0) ...[
                OrderSummaryItem(
                  title: L10n.tr().discount,
                  value: summary!.itemDiscount,
                  isDiscount: true,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // VAT Amount
              if ((summary?.vatAmount ?? 0.0) != 0) ...[
                OrderSummaryItem(
                  title: 'VAT',
                  value: summary!.vatAmount,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // Service Fees
              if ((summary?.serviceFees ?? orderDetail.serviceFee) != 0) ...[
                OrderSummaryItem(
                  title: L10n.tr().serviceFee,
                  value: summary?.serviceFees ?? orderDetail.serviceFee,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // Coupon Code (if exists)
              if (summary?.coupon != null && summary!.coupon!.isNotEmpty) ...[
                OrderSummaryItem(
                  title: L10n.tr().promoCodeName,
                  value: summary.coupon!,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // Coupon Discount
              if ((summary?.couponDiscount ?? 0.0) != 0) ...[
                OrderSummaryItem(
                  title: L10n.tr().promoCode,
                  value: summary!.couponDiscount,
                  isDiscount: true,
                  formattedValue: voucherFormatted,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // Delivery Fees
              if ((summary?.deliveryFees ?? orderDetail.deliveryFee) != 0) ...[
                OrderSummaryItem(
                  title: L10n.tr().deliveryFee,
                  value: summary?.deliveryFees ?? orderDetail.deliveryFee,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              // Delivery Fees Discount
              if ((summary?.deliveryFeesDiscount ?? 0.0) != 0) ...[
                OrderSummaryItem(
                  title: L10n.tr().deliveryFeeDiscount,
                  value: summary!.deliveryFeesDiscount,
                  isDiscount: true,
                ),
                const SizedBox(height: _itemSpacing),
              ],
              const DashedBorder(
                width: 10,
                gap: 8,
                color: Co.gryPrimary,
                thickness: 1.5,
              ),
              const VerticalSpacing(_finalSpacing),
              FinalTotalRow(total: finalTotal),
              OrderSummaryItem(
                title: L10n.tr().paymentMethod,
                value: summary?.paymentMethod ?? orderDetail.paymentMethod,
              ),
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

    final isPercent = orderDetail.voucherDiscountType!.toLowerCase().contains(
      'percent',
    );
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
}

class OrderSummaryItem extends StatelessWidget {
  const OrderSummaryItem({
    super.key,
    required this.title,
    required this.value,
    this.isDiscount = false,
    this.formattedValue,
  });

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
        Text(
          title,
          style: TStyle.blackSemi(16, font: FFamily.roboto),
        ),
        Text(
          valueText,
          style: TStyle.blackSemi(18, font: FFamily.roboto),
        ),
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
                style: TStyle.blackBold(12, font: FFamily.roboto).copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        const HorizontalSpacing(12),
        Text(
          Helpers.getProperPrice(total),
          style: TStyle.burbleSemi(20, font: FFamily.roboto),
        ),
      ],
    );
  }
}
