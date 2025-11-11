import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class YourPointsWidget extends StatelessWidget {
  const YourPointsWidget({
    super.key,
    required this.mainColor,
    required this.firstColorText,
    required this.secondTextColor,
    required this.availablePoints,
    required this.earningPoints,
    required this.earningPerPound,
    required this.conversionRate,
    required this.conversionPound,
    required this.expirationPoints,
    required this.expirationDate,
  });

  final Color mainColor;
  final Color firstColorText;
  final Color secondTextColor;
  final int availablePoints;
  final int earningPoints;
  final int earningPerPound;
  final int conversionRate;
  final int conversionPound;
  final int expirationPoints;
  final String expirationDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            L10n.tr().yourPoints,
            style: TStyle.whiteRegular(20, font: FFamily.roboto).copyWith(color: firstColorText),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(Assets.availablePointsIc),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    availablePoints.toString(),
                    style: TStyle.whiteSemi(24, font: FFamily.roboto).copyWith(color: firstColorText),
                  ),
                  Text(
                    L10n.tr().availablePoints,
                    style: TStyle.whiteSemi(20, font: FFamily.roboto).copyWith(color: secondTextColor),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          YourPointsItem(
            icon: Assets.earningPointsIc,
            subTitle: '$earningPoints ${L10n.tr().pointsPer} ${Helpers.getProperPrice(earningPerPound)}',
            title: L10n.tr().earningRate,
            firstTextColor: firstColorText,
            secondTextColor: secondTextColor,
          ),
          YourPointsItem(
            icon: Assets.conversionRateIc,
            subTitle: '$conversionRate ${L10n.tr().points} = ${Helpers.getProperPrice(conversionPound)}',
            title: L10n.tr().conversionRate,
            firstTextColor: firstColorText,
            secondTextColor: secondTextColor,
          ),
          YourPointsItem(
            icon: Assets.expirationIc,
            subTitle: '$expirationPoints ${L10n.tr().validUntill} $expirationDate',
            title: L10n.tr().expiration,
            firstTextColor: firstColorText,
            secondTextColor: secondTextColor,
          ),
        ],
      ),
    );
  }
}

class YourPointsItem extends StatelessWidget {
  const YourPointsItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.firstTextColor,
    required this.secondTextColor,
  });

  final String title;
  final String subTitle;
  final String icon;
  final Color firstTextColor;
  final Color secondTextColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TStyle.whiteSemi(16, font: FFamily.roboto).copyWith(color: firstTextColor),
              ),
              const VerticalSpacing(4),
              Text(
                subTitle,
                style: TStyle.burbleMed(14, font: FFamily.roboto).copyWith(color: secondTextColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
