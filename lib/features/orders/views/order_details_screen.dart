import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/orders/domain/entities/delivery_address_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_item_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_vendor_entity.dart';
import 'package:gazzer/features/orders/domain/entities/order_status.dart';
import 'package:gazzer/features/orders/domain/entities/order_vendor_entity.dart';
import 'package:intl/intl.dart';

/// Screen displaying detailed information about a specific order
class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({
    super.key,
    required this.orderId,
  });

  final int orderId;

  static const route = '/order-details';

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  // Constants
  static const double _cardBorderRadius = 16.0;
  static const double _badgeBorderRadius = 20.0;
  static const double _defaultSpacing = 24.0;
  static const double _smallSpacing = 4.0;
  static const double _mediumSpacing = 12.0;
  static const double _vendorLogoSize = 48.0;
  static const double _itemImageSize = 55.0;
  static const String _dateFormat = 'MMM dd - yyyy';
  static const String _defaultVendorInitial = 'V';

  final Map<int, bool> _expandedVendors = {};
  late final OrderDetailEntity orderDetail;

  @override
  void initState() {
    super.initState();
    orderDetail = OrderDetailEntity(
      orderId: widget.orderId,
      orderDate: DateTime.now(),
      deliveryAddress: const DeliveryAddressEntity(
        address: 'ASD ASD',
        name: 'ahmed mahmoud',
        mobileNumber: '01112227687423',
      ),
      status: OrderStatus.delivered,
      vendors: [
        const OrderDetailVendorEntity(
          vendor: OrderVendorEntity(id: 2, name: 'Asd', image: '', logo: ''),
          items: [
            OrderDetailItemEntity(
              id: 1,
              name: 'Beef',
              image: '',
              quantity: 10,
              price: 1000,
            ),
          ],
        ),
      ],
      deliveryTimeMinutes: 20,
      subTotal: 1000.0,
      discount: 100.0,
      deliveryFee: 20.0,
      serviceFee: 15.0,
      total: 935.0,
      voucherCode: 'VOUCHER123',
      voucherDiscountType: 'percentage',
      voucherDiscountAmount: 10.0,
      paymentMethod: 'Cash',
    );

    _expandFirstVendor();
  }

  void _expandFirstVendor() {
    if (orderDetail.vendors.isNotEmpty) {
      _expandedVendors[0] = true;
    }
  }

  void _toggleVendor(int index) {
    setState(() {
      _expandedVendors[index] = !(_expandedVendors[index] ?? false);
    });
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.day == now.day && date.month == now.month && date.year == now.year;
  }

  String _formatOrderDate(DateTime date) {
    final dateFormat = DateFormat(_dateFormat);
    return _isToday(date) ? 'Today ${dateFormat.format(date)}' : dateFormat.format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Co.bg,
      appBar: MainAppBar(
        showCart: false,
        title: 'Order Details',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrderHeaderSection(
              orderId: orderDetail.orderId,
              orderDate: orderDetail.orderDate,
              status: orderDetail.status,
              deliveryTimeMinutes: orderDetail.deliveryTimeMinutes,
              onFormatDate: _formatOrderDate,
            ),
            const SizedBox(height: _defaultSpacing),
            _DeliveryAddressCard(address: orderDetail.deliveryAddress),
            const SizedBox(height: _defaultSpacing),
            ..._buildVendorSections(),
            const SizedBox(height: _defaultSpacing),
            _OrderSummarySection(orderDetail: orderDetail),
            const SizedBox(height: _defaultSpacing),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Co.earnedMoney,
                borderRadius: BorderRadius.circular(40),
              ),
              alignment: AlignmentDirectional.center,
              child: Text(
                'You have earned 2342 points',
                style: TStyle.robotBlackMedium(),
              ),
            ),
            const SizedBox(height: _defaultSpacing),
            MainBtn(
              onPressed: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(Assets.customerSupportIc),
                  const HorizontalSpacing(10),
                  Text(
                    L10n.tr().getHelp,
                    style: TStyle.robotBlackMedium().copyWith(color: Co.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: _defaultSpacing),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildVendorSections() {
    return orderDetail.vendors.asMap().entries.map((entry) {
      final index = entry.key;
      final vendorDetail = entry.value;
      final isExpanded = _expandedVendors[index] ?? false;

      return Padding(
        padding: const EdgeInsets.only(bottom: _mediumSpacing),
        child: _VendorSection(
          vendorDetail: vendorDetail,
          isExpanded: isExpanded,
          onToggle: () => _toggleVendor(index),
        ),
      );
    }).toList();
  }
}

/// Header section displaying order ID, date, status, and delivery time
class _OrderHeaderSection extends StatelessWidget {
  const _OrderHeaderSection({
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
          child: _OrderInfoColumn(
            orderId: orderId,
            formattedDate: onFormatDate(orderDate),
          ),
        ),
        Expanded(
          child: _StatusColumn(
            status: status,
            deliveryTimeMinutes: deliveryTimeMinutes,
          ),
        ),
      ],
    );
  }
}

class _OrderInfoColumn extends StatelessWidget {
  const _OrderInfoColumn({
    required this.orderId,
    required this.formattedDate,
  });

  final int orderId;
  final String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order ID: #$orderId',
          style: TStyle.blackBold(16),
        ),
        const SizedBox(height: _OrderDetailsScreenState._smallSpacing),
        Text(
          formattedDate,
          style: TStyle.blackRegular(14).copyWith(color: Co.grey),
        ),
      ],
    );
  }
}

class _StatusColumn extends StatelessWidget {
  const _StatusColumn({
    required this.status,
    this.deliveryTimeMinutes,
  });

  final OrderStatus status;
  final int? deliveryTimeMinutes;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _StatusBadge(status: status),
        if (deliveryTimeMinutes != null) ...[
          const SizedBox(height: _OrderDetailsScreenState._smallSpacing),
          _DeliveryTimeText(minutes: deliveryTimeMinutes!),
        ],
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: status.badgeColor,
        borderRadius: BorderRadius.circular(
          _OrderDetailsScreenState._badgeBorderRadius,
        ),
      ),
      child: Text(
        status.label,
        style: TStyle.blackBold(12),
      ),
    );
  }
}

class _DeliveryTimeText extends StatelessWidget {
  const _DeliveryTimeText({required this.minutes});

  final int minutes;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Take $minutes min',
      style: TStyle.blackRegular(12).copyWith(color: Co.grey),
    );
  }
}

/// Card displaying delivery address information
class _DeliveryAddressCard extends StatelessWidget {
  const _DeliveryAddressCard({required this.address});

  final DeliveryAddressEntity address;

  static const double _padding = 16.0;
  static const double _iconSpacing = 12.0;
  static const double _textSpacing = 4.0;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Container(
      padding: const EdgeInsets.all(_padding),
      decoration: BoxDecoration(
        color: Co.white,
        borderRadius: BorderRadius.circular(
          _OrderDetailsScreenState._cardBorderRadius,
        ),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.locationIc),
          const SizedBox(width: _iconSpacing),
          Expanded(
            child: _AddressInfoColumn(
              address: address.address,
              name: address.name,
              mobileNumber: address.mobileNumber,
              deliveryAddressLabel: l10n.deliveryAddress,
              mobileNumberLabel: l10n.mobileNumber,
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressInfoColumn extends StatelessWidget {
  const _AddressInfoColumn({
    required this.address,
    required this.name,
    required this.mobileNumber,
    required this.deliveryAddressLabel,
    required this.mobileNumberLabel,
  });

  final String address;
  final String name;
  final String mobileNumber;
  final String deliveryAddressLabel;
  final String mobileNumberLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          deliveryAddressLabel,
          style: TStyle.robotBlackSmall(),
        ),
        const SizedBox(height: _DeliveryAddressCard._textSpacing),
        Text(
          address,
          style: TStyle.robotBlackThin(),
        ),
        const SizedBox(height: _DeliveryAddressCard._textSpacing),
        Text(
          name,
          style: TStyle.robotBlackSmall(),
        ),
        const SizedBox(height: _DeliveryAddressCard._textSpacing),
        Text(
          '$mobileNumberLabel: $mobileNumber',
          style: TStyle.robotBlackSmall(),
        ),
      ],
    );
  }
}

/// Expandable section displaying vendor information and their order items
class _VendorSection extends StatelessWidget {
  const _VendorSection({
    required this.vendorDetail,
    required this.isExpanded,
    required this.onToggle,
  });

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
        borderRadius: BorderRadius.circular(
          _OrderDetailsScreenState._cardBorderRadius,
        ),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Column(
        children: [
          _VendorHeader(
            vendor: vendorDetail.vendor,
            itemsCount: vendorDetail.itemsCount,
            isExpanded: isExpanded,
            onTap: onToggle,
          ),
          if (isExpanded) const Divider(),
          if (isExpanded) _VendorItemsList(items: vendorDetail.items),
        ],
      ),
    );
  }
}

class _VendorHeader extends StatelessWidget {
  const _VendorHeader({
    required this.vendor,
    required this.itemsCount,
    required this.isExpanded,
    required this.onTap,
  });

  final OrderVendorEntity vendor;
  final int itemsCount;
  final bool isExpanded;
  final VoidCallback onTap;

  String _getVendorInitial() {
    if (vendor.name.isEmpty) {
      return _OrderDetailsScreenState._defaultVendorInitial;
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
        padding: const EdgeInsets.all(_VendorSection._headerPadding),
        child: Row(
          children: [
            _VendorLogo(
              imageUrl: _getVendorImageUrl(),
              fallbackInitial: _getVendorInitial(),
            ),
            const SizedBox(width: _VendorSection._iconSpacing),
            Expanded(
              child: Text(
                vendor.name,
                style: TStyle.blackBold(14),
              ),
            ),
            _ItemsCountIndicator(count: itemsCount),
            const SizedBox(width: _VendorSection._iconSpacing),
            Icon(
              isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class _VendorLogo extends StatelessWidget {
  const _VendorLogo({
    this.imageUrl,
    required this.fallbackInitial,
  });

  final String? imageUrl;
  final String fallbackInitial;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _OrderDetailsScreenState._vendorLogoSize,
      height: _OrderDetailsScreenState._vendorLogoSize,
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(_VendorSection._logoBorderRadius),
      ),
      child: imageUrl != null && imageUrl!.isNotEmpty
          ? ClipOval(
              child: CustomNetworkImage(
                imageUrl!,
                width: _OrderDetailsScreenState._vendorLogoSize,
                height: _OrderDetailsScreenState._vendorLogoSize,
                fit: BoxFit.cover,
              ),
            )
          : Center(
              child: Text(
                fallbackInitial,
                style: TStyle.blackBold(18),
              ),
            ),
    );
  }
}

class _ItemsCountIndicator extends StatelessWidget {
  const _ItemsCountIndicator({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.tr();
    return Row(
      children: [
        SvgPicture.asset(Assets.cartItemIc),
        const SizedBox(width: _VendorSection._cartIconSpacing),
        Text(
          '$count ${l10n.items}',
          style: TStyle.robotBlackMedium(),
        ),
      ],
    );
  }
}

class _VendorItemsList extends StatelessWidget {
  const _VendorItemsList({required this.items});

  final List<OrderDetailItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        _VendorSection._itemsListPadding,
        0,
        _VendorSection._itemsListPadding,
        _VendorSection._itemsListPadding,
      ),
      child: Column(
        children: items
            .map<Widget>(
              (item) => Padding(
                padding: const EdgeInsets.only(
                  bottom: _VendorSection._itemSpacing,
                ),
                child: _OrderItemTile(item: item),
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Tile displaying a single order item with image, quantity, name, add-ons, and price
class _OrderItemTile extends StatelessWidget {
  const _OrderItemTile({required this.item});

  final OrderDetailItemEntity item;

  static const double _imageBorderRadius = 8.0;
  static const double _badgeBorderRadius = 8.0;
  static const double _imageSpacing = 12.0;
  static const double _addOnsSpacing = 4.0;
  static const double _quantityBadgePadding = 6.0;
  static const String _addOnsPrefix = 'Add-ons: ';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _ItemImageWithBadge(
          imageUrl: item.image,
          quantity: item.quantity,
        ),
        const SizedBox(width: _imageSpacing),
        Expanded(
          child: _ItemInfoColumn(
            name: item.name,
            addOns: item.addOns,
          ),
        ),
        _ItemPrice(price: item.price),
      ],
    );
  }
}

class _ItemImageWithBadge extends StatelessWidget {
  const _ItemImageWithBadge({
    required this.imageUrl,
    required this.quantity,
  });

  final String imageUrl;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(
            _OrderItemTile._imageBorderRadius,
          ),
          child: CustomNetworkImage(
            imageUrl,
            width: _OrderDetailsScreenState._itemImageSize,
            height: _OrderDetailsScreenState._itemImageSize,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: _QuantityBadge(quantity: quantity),
        ),
      ],
    );
  }
}

class _QuantityBadge extends StatelessWidget {
  const _QuantityBadge({required this.quantity});

  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _OrderItemTile._quantityBadgePadding,
        vertical: _OrderItemTile._quantityBadgePadding / 3,
      ),
      decoration: BoxDecoration(
        color: Co.purple,
        borderRadius: BorderRadius.circular(_OrderItemTile._badgeBorderRadius),
      ),
      child: Text(
        '$quantity',
        style: TStyle.whiteBold(10),
      ),
    );
  }
}

class _ItemInfoColumn extends StatelessWidget {
  const _ItemInfoColumn({
    required this.name,
    required this.addOns,
  });

  final String name;
  final List<String> addOns;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TStyle.blackBold(14),
        ),
        if (addOns.isNotEmpty) ...[
          const SizedBox(height: _OrderItemTile._addOnsSpacing),
          Text(
            '${_OrderItemTile._addOnsPrefix}${addOns.join(', ')}',
            style: TStyle.blackRegular(12).copyWith(color: Co.grey),
          ),
        ],
      ],
    );
  }
}

class _ItemPrice extends StatelessWidget {
  const _ItemPrice({required this.price});

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      Helpers.getProperPrice(price),
      style: TStyle.blackBold(14),
    );
  }
}

/// Order summary section displaying pricing breakdown
class _OrderSummarySection extends StatelessWidget {
  const _OrderSummarySection({required this.orderDetail});

  final OrderDetailEntity orderDetail;

  static const double _padding = 16.0;
  static const double _borderRadius = 12.0;
  static const double _itemSpacing = 8.0;
  static const double _finalSpacing = 12.0;

  @override
  Widget build(BuildContext context) {
    final finalTotal = _calculateFinalTotal();
    final voucherFormatted = _getVoucherFormatted();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              L10n.tr().orderSummary,
              style: TStyle.robotBlackTitle(),
            ),
            Text(
              L10n.tr().viewReceipt,
              style: TStyle.robotBlackRegular().copyWith(color: Co.purple, decoration: TextDecoration.underline),
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
              if (orderDetail.subTotal != 0)
                _OrderSummaryItem(
                  title: L10n.tr().subTotal,
                  value: orderDetail.subTotal,
                ),
              const SizedBox(height: _itemSpacing),
              if (orderDetail.discount != 0)
                _OrderSummaryItem(
                  title: L10n.tr().discount,
                  value: orderDetail.discount,
                  isDiscount: true,
                ),
              const SizedBox(height: _itemSpacing),
              if (orderDetail.deliveryFee != 0)
                _OrderSummaryItem(
                  title: L10n.tr().deliveryFee,
                  value: orderDetail.deliveryFee,
                ),
              const SizedBox(height: _itemSpacing),
              if (orderDetail.serviceFee != 0)
                _OrderSummaryItem(
                  title: L10n.tr().serviceFee,
                  value: orderDetail.serviceFee,
                ),
              const SizedBox(height: _itemSpacing),
              if (voucherFormatted != null) ...[
                _OrderSummaryItem(
                  title: L10n.tr().totalBeforeCode,
                  value: orderDetail.total,
                ),
                const SizedBox(height: _itemSpacing),
                _OrderSummaryItem(
                  title: L10n.tr().promoCode,
                  value: orderDetail.voucherDiscountAmount ?? 0.0,
                  isDiscount: true,
                  formattedValue: voucherFormatted,
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
              _FinalTotalRow(total: finalTotal),
              _OrderSummaryItem(
                title: L10n.tr().paymentMethod,
                value: orderDetail.paymentMethod,
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

  String? _getVoucherFormatted() {
    if (orderDetail.voucherCode == null ||
        orderDetail.voucherDiscountType == null ||
        orderDetail.voucherDiscountAmount == null ||
        orderDetail.voucherDiscountAmount! <= 0) {
      return null;
    }

    final isPercent = orderDetail.voucherDiscountType!.toLowerCase().contains(
      'percent',
    );
    if (isPercent) {
      final deduction = orderDetail.total * (orderDetail.voucherDiscountAmount! / 100.0);
      return '- ${orderDetail.voucherDiscountAmount!.toStringAsFixed(0)}% (${deduction.toStringAsFixed(2)}${L10n.tr().egp})';
    } else {
      return '- ${Helpers.getProperPrice(orderDetail.voucherDiscountAmount!)}';
    }
  }
}

class _OrderSummaryItem extends StatelessWidget {
  const _OrderSummaryItem({
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

class _FinalTotalRow extends StatelessWidget {
  const _FinalTotalRow({required this.total});

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
