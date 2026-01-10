import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';

class CartAddressWidget extends StatelessWidget {
  const CartAddressWidget({super.key, required this.address});
  final AddressModel address;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: AppConst.defaultBorderRadius),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Co.secondary,
              child: SvgPicture.asset(address.labelSvg, width: 20, height: 20, colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn)),
            ),
            const HorizontalSpacing(20),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(address.labelType.label ?? address.label, style: context.style16500.copyWith(color: Co.purple), maxLines: 2),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: address.provinceName),
                        TextSpan(text: ', ${address.zoneName}'),
                        TextSpan(text: ', ${L10n.tr().building} ${address.building}'),
                        TextSpan(text: ', ${L10n.tr().floor} ${address.floor}'),
                        TextSpan(text: ', ${L10n.tr().apartmentNumber} ${address.apartment}'),
                        if (address.landmark != null) TextSpan(text: ', ${L10n.tr().landmark} ${address.landmark}.'),
                      ],
                      style: context.style12400.copyWith(height: 1.7, color: Co.darkGrey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
