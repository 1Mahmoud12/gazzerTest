import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/features/profile/presentation/model/address_model.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key, required this.address});
  final AddressModel address;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: AppConst.defaultBorderRadius,
        border: address.isDefault ? null : Border.all(color: Co.secondary),
        color: address.isDefault ? Colors.white24 : null,
      ),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 23,
                  backgroundColor: Co.white,
                  child: SvgPicture.asset(address.labelSvg, width: 20, height: 20),
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
