import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/orders/domain/entities/delivery_address_entity.dart';
import 'package:gazzer/features/orders/views/widgets/orderDetailsWidgets/order_details_constants.dart';

/// Card displaying delivery address information
class DeliveryAddressCard extends StatelessWidget {
  const DeliveryAddressCard({super.key, required this.address});

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
        borderRadius: BorderRadius.circular(OrderDetailsConstants.cardBorderRadius),
        border: Border.all(color: Co.lightGrey),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(Assets.locationIc),
          const SizedBox(width: _iconSpacing),
          Expanded(
            child: AddressInfoColumn(
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

class AddressInfoColumn extends StatelessWidget {
  const AddressInfoColumn({
    super.key,
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
        Text(deliveryAddressLabel, style: context.style14400),
        const SizedBox(height: DeliveryAddressCard._textSpacing),
        Text(address, style: context.style12400),
        const SizedBox(height: DeliveryAddressCard._textSpacing),
        Text(name, style: context.style14400),
        const SizedBox(height: DeliveryAddressCard._textSpacing),
        Text('$mobileNumberLabel: $mobileNumber', style: context.style14400),
      ],
    );
  }
}
