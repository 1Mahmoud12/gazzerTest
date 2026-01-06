import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_constants.dart';

/// Tile displaying a single order item with image, quantity, name, add-ons, and price
class OrderItemTile extends StatelessWidget {
  const OrderItemTile({super.key, required this.item});

  final OrderDetailItemEntity item;

  static const double _imageBorderRadius = 8.0;
  static const double _badgeBorderRadius = 8.0;
  static const double _imageSpacing = 12.0;
  static const double _addOnsSpacing = 4.0;
  static const double _quantityBadgePadding = 6.0;
  static String _addOnsPrefix = '${L10n.tr().addons}: ';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ItemImageWithBadge(imageUrl: item.image, quantity: item.quantity),
        const SizedBox(width: _imageSpacing),
        Expanded(
          child: ItemInfoColumn(name: item.name, addOns: item.addOns),
        ),
        ItemPrice(price: item.price),
      ],
    );
  }
}

class ItemImageWithBadge extends StatelessWidget {
  const ItemImageWithBadge({super.key, required this.imageUrl, required this.quantity});

  final String imageUrl;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(OrderItemTile._imageBorderRadius),
          child: CustomNetworkImage(
            imageUrl,
            width: OrderDetailsConstants.itemImageSize,
            height: OrderDetailsConstants.itemImageSize,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(top: 0, left: 0, child: QuantityBadge(quantity: quantity)),
      ],
    );
  }
}

class QuantityBadge extends StatelessWidget {
  const QuantityBadge({super.key, required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: OrderItemTile._quantityBadgePadding, vertical: OrderItemTile._quantityBadgePadding / 3),
      decoration: BoxDecoration(color: Co.purple, borderRadius: BorderRadius.circular(OrderItemTile._badgeBorderRadius)),
      child: Text(
        '$quantity',
        style: TStyle.robotBlackThin().copyWith(color: Co.white, fontWeight: TStyle.bold),
      ),
    );
  }
}

class ItemInfoColumn extends StatelessWidget {
  const ItemInfoColumn({super.key, required this.name, required this.addOns});

  final String name;
  final List<String> addOns;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),
        if (addOns.isNotEmpty) ...[
          const SizedBox(height: OrderItemTile._addOnsSpacing),
          Text('${OrderItemTile._addOnsPrefix}${addOns.join(', ')}', style: TStyle.robotBlackThin().copyWith(color: Co.grey)),
        ],
      ],
    );
  }
}

class ItemPrice extends StatelessWidget {
  const ItemPrice({super.key, required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(Helpers.getProperPrice(price), style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold));
  }
}
