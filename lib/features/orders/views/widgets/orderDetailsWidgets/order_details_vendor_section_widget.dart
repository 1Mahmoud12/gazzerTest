import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_vendor_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_constants.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_item_tile_widget.dart';

/// Expandable section displaying vendor information and their order items
class VendorSection extends StatelessWidget {
  const VendorSection({super.key, required this.vendorDetail, required this.isExpanded, required this.onToggle});

  final OrderDetailVendorEntity vendorDetail;
  final bool isExpanded;
  final VoidCallback onToggle;

  static const double _headerPadding = 16.0;
  static const double _logoBorderRadius = 8.0;
  static const double _itemsListPadding = 16.0;
  static const double _itemSpacing = 16.0;
  static const double _iconSpacing = 12.0;
  static const double _cartIconSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Co.white,
        borderRadius: BorderRadius.circular(OrderDetailsConstants.cardBorderRadius),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Column(
        children: [
          VendorHeader(vendor: vendorDetail.vendor, itemsCount: vendorDetail.itemsCount, isExpanded: isExpanded, onTap: onToggle),
          if (isExpanded) const Divider(),
          if (isExpanded) VendorItemsList(items: vendorDetail.items),
        ],
      ),
    );
  }
}

class VendorHeader extends StatelessWidget {
  const VendorHeader({super.key, required this.vendor, required this.itemsCount, required this.isExpanded, required this.onTap});

  final OrderVendorEntity vendor;
  final int itemsCount;
  final bool isExpanded;
  final VoidCallback onTap;

  String _getVendorInitial() {
    if (vendor.name.isEmpty) {
      return OrderDetailsConstants.defaultVendorInitial;
    }
    return vendor.name.substring(0, 1).toUpperCase();
  }

  String? _getVendorImageUrl() {
    return vendor.logo ?? vendor.image;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(VendorSection._headerPadding),
        child: Row(
          children: [
            VendorLogo(imageUrl: _getVendorImageUrl(), fallbackInitial: _getVendorInitial()),
            const SizedBox(width: VendorSection._iconSpacing),
            Expanded(
              child: Text(vendor.name, style: TStyle.robotBlackRegular14().copyWith(fontWeight: TStyle.bold)),
            ),
            ItemsCountIndicator(count: itemsCount),
            const SizedBox(width: VendorSection._iconSpacing),
            Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.black),
          ],
        ),
      ),
    );
  }
}

class VendorLogo extends StatelessWidget {
  const VendorLogo({super.key, this.imageUrl, required this.fallbackInitial});

  final String? imageUrl;
  final String fallbackInitial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: OrderDetailsConstants.vendorLogoSize,
      height: OrderDetailsConstants.vendorLogoSize,
      decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(VendorSection._logoBorderRadius)),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipOval(
              child: CustomNetworkImage(
                imageUrl!,
                width: OrderDetailsConstants.vendorLogoSize,
                height: OrderDetailsConstants.vendorLogoSize,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Text(fallbackInitial, style: TStyle.robotBlackMedium().copyWith(fontWeight: TStyle.bold)),
            ),
    );
  }
}

class ItemsCountIndicator extends StatelessWidget {
  const ItemsCountIndicator({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Row(
      children: [
        SvgPicture.asset(Assets.cartItemIc),
        const SizedBox(width: VendorSection._cartIconSpacing),
        Text('$count ${l10n.items}', style: TStyle.robotBlackMedium()),
      ],
    );
  }
}

class VendorItemsList extends StatelessWidget {
  const VendorItemsList({super.key, required this.items});

  final List<OrderDetailItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(VendorSection._itemsListPadding, 0, VendorSection._itemsListPadding, VendorSection._itemsListPadding),
      child: Column(
        children: items
            .map<Widget>(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: VendorSection._itemSpacing),
                child: OrderItemTile(item: item),
              ),
            )
            .toList(),
      ),
    );
  }
}
