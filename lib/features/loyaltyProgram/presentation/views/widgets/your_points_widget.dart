import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/tier_visual_details.dart';

class YourPointsWidget extends StatelessWidget {
  const YourPointsWidget({
    super.key,
    required this.visual,

    required this.availablePoints,
    required this.earningPoints,
    required this.earningPerPound,
    required this.conversionRate,
    required this.conversionPound,
    required this.expirationPoints,
    required this.expirationDate,
    required this.totalPoints,
  });

  final TierVisualDetails visual;
  final int availablePoints;
  final int totalPoints;
  final int earningPoints;
  final int earningPerPound;
  final int conversionRate;
  final int conversionPound;
  final int expirationPoints;
  final String expirationDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: visual.mainColor, borderRadius: BorderRadius.circular(24)),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(L10n.tr().yourPoints, style: context.style20500.copyWith(color: visual.primaryTextColor)),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(Assets.availablePointsIc),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(availablePoints.toString(), style: context.style20500.copyWith(color: visual.primaryTextColor)),
                  Text(L10n.tr().availablePoints, style: context.style20500.copyWith(color: visual.secondaryTextColor)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          YourPointsItem(
            icon: Assets.earningPointsIc,
            subTitle: '$earningPoints ${L10n.tr().pointsPer} ${Helpers.getProperPrice(earningPerPound)}',
            title: L10n.tr().earningRate,
            firstTextColor: visual.primaryTextColor,
            secondTextColor: visual.secondaryTextColor,
            iconColor: visual.iconColor,
            backgroundColor: visual.backgroundIconColor,
          ),
          YourPointsItem(
            icon: Assets.conversionRateIc,
            subTitle: '$conversionRate ${L10n.tr().points} = ${Helpers.getProperPrice(conversionPound)}',
            title: L10n.tr().conversionRate,
            firstTextColor: visual.primaryTextColor,
            secondTextColor: visual.secondaryTextColor,
            iconColor: visual.iconColor,
            backgroundColor: visual.backgroundIconColor,
          ),
          YourPointsItem(
            icon: Assets.expirationIc,
            subTitle: '$expirationPoints ${L10n.tr().validUntill} $expirationDate',
            title: L10n.tr().expiration,
            firstTextColor: visual.primaryTextColor,
            secondTextColor: visual.secondaryTextColor,
            iconColor: visual.iconColor,
            backgroundColor: visual.backgroundIconColor,
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
    required this.iconColor,
    required this.backgroundColor,
  });

  final String title;
  final String subTitle;
  final String icon;
  final Color firstTextColor;
  final Color secondTextColor;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
            child: SvgPicture.asset(icon, width: 20, height: 20, colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn)),
          ),
          const SizedBox(width: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.style16500.copyWith(color: firstTextColor)),
              const VerticalSpacing(4),
              Text(
                subTitle,
                style: context.style14400.copyWith(color: Co.purple, fontWeight: TStyle.medium),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
