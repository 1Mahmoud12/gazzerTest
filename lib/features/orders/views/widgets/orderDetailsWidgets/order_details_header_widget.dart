import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_constants.dart';

/// Header section displaying order ID, date, status, and delivery time
class OrderDetailsHeaderSection extends StatelessWidget {
  const OrderDetailsHeaderSection({
    super.key,
    required this.orderId,
    required this.orderDate,
    required this.status,
    this.deliveryTimeMinutes,
    required this.onFormatDate,
  });

  final int orderId;
  final DateTime orderDate;
  final OrderStatus status;
  final int? deliveryTimeMinutes;
  final String Function(DateTime) onFormatDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OrderInfoColumn(orderId: orderId, formattedDate: onFormatDate(orderDate)),
        ),
        Expanded(
          child: StatusColumn(status: status, deliveryTimeMinutes: deliveryTimeMinutes),
        ),
      ],
    );
  }
}

class OrderInfoColumn extends StatelessWidget {
  const OrderInfoColumn({super.key, required this.orderId, required this.formattedDate});

  final int orderId;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('${L10n.tr().orderId}: #$orderId', style: TStyle.robotBlackRegular().copyWith(fontWeight: TStyle.bold)),
        const SizedBox(height: OrderDetailsConstants.smallSpacing),
        Text(formattedDate, style: TStyle.robotBlackRegular().copyWith(color: Co.grey)),
      ],
    );
  }
}

class StatusColumn extends StatelessWidget {
  const StatusColumn({super.key, required this.status, this.deliveryTimeMinutes});

  final OrderStatus status;
  final int? deliveryTimeMinutes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StatusBadge(status: status),
        if (deliveryTimeMinutes != null) ...[
          const SizedBox(height: OrderDetailsConstants.smallSpacing),
          DeliveryTimeText(minutes: deliveryTimeMinutes!),
        ],
      ],
    );
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: status.badgeColor, borderRadius: BorderRadius.circular(OrderDetailsConstants.badgeBorderRadius)),
      child: Text(status.label, style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),
    );
  }
}

class DeliveryTimeText extends StatelessWidget {
  const DeliveryTimeText({super.key, required this.minutes});

  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Text('${L10n.tr().take} $minutes ${L10n.tr().min}', style: TStyle.robotBlackThin().copyWith(color: Co.grey));
  }
}
