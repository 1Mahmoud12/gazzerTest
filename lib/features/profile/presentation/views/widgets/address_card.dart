import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address});
  final AddressModel address;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppConst.defaultBorderRadius,
        border: address.isDefault ? null : Border.all(color: Co.purple),
      ),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Co.secondary,
                  child: SvgPicture.asset(
                    address.labelSvg,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                  ),
                ),
                const HorizontalSpacing(20),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: address.labelType.label ?? address.label,
                          style: TStyle.primarySemi(16),
                        ),
                        const TextSpan(text: '\n'),
                        TextSpan(text: "${address.provinceName}, "),
                        TextSpan(text: "${address.zoneName}, "),
                        TextSpan(text: address.street),
                        TextSpan(text: ", ${L10n.tr().floor} ${address.floor}"),
                        TextSpan(text: ", ${L10n.tr().apartmentNumber} ${address.apartment}."),
                        if (address.description != null) TextSpan(text: " ${address.description}."),
                        if (address.landmark != null) TextSpan(text: " ${L10n.tr().landmark} ${address.landmark}."),
                      ],
                      style: TStyle.greyRegular(12).copyWith(height: 1.7),
                    ),
                  ),
                ),
                Column(
                  spacing: 4,
                  children: [
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(Icons.edit, color: Co.purple),
                    ),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        padding: const EdgeInsets.all(5),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: const Icon(CupertinoIcons.delete, color: Co.purple),
                    ),
                  ],
                ),
              ],
            ),
            if (!address.isDefault)
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), minimumSize: Size.zero),
                child: Text(
                  L10n.tr().setAsDefault,
                  style: TStyle.secondarySemi(14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
