import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class OurTierBenefitsWidget extends StatelessWidget {
  const OurTierBenefitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          L10n.tr().ourTierBenefits,
          style: TStyle.blackMedium(22, font: FFamily.roboto),
        ),
        const SizedBox(height: 16),
        const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: [
              ProgramWidget(mainColor: Co.purple, textColor: Co.white, iconColor: Co.purple, bgIconColo: Co.lightPurple, nameProgram: 'Hero'),
              ProgramWidget(mainColor: Co.purple600, textColor: Co.white, iconColor: Co.white, bgIconColo: Co.purple, nameProgram: 'Winner'),
              ProgramWidget(mainColor: Co.purple200, textColor: Co.black, iconColor: Co.white, bgIconColo: Co.purple, nameProgram: 'Silver'),
              ProgramWidget(mainColor: Co.purple100, textColor: Co.black, iconColor: Co.white, bgIconColo: Co.purple, nameProgram: 'Gainer'),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgramWidget extends StatelessWidget {
  final Color mainColor;
  final Color textColor;
  final Color iconColor;
  final Color bgIconColo;
  final String nameProgram;

  const ProgramWidget({
    super.key,
    required this.mainColor,
    required this.textColor,
    required this.iconColor,
    required this.bgIconColo,
    required this.nameProgram,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: mainColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$nameProgram tier benefits',
            style: TStyle.whiteBold(20, font: FFamily.roboto).copyWith(color: textColor),
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgBirthdayIc,
            title: L10n.tr().freeDelivery,
            available: true,
            iconColor: iconColor,
            textColor: textColor,
            bgColor: bgIconColo,
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgOfferIc,
            title: L10n.tr().exclusiveVoucher,
            available: false,
            iconColor: iconColor,
            textColor: textColor,
            bgColor: bgIconColo,
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgOfferIc,
            title: L10n.tr().exclusiveDiscount,
            available: false,
            iconColor: iconColor,
            textColor: textColor,
            bgColor: bgIconColo,
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgOfferIc,
            title: L10n.tr().exclusiveAccessLevel,
            available: false,
            iconColor: iconColor,
            textColor: textColor,
            bgColor: bgIconColo,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class TierRowWidget extends StatelessWidget {
  const TierRowWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.available,
    required this.iconColor,
    required this.textColor,
    required this.bgColor,
  });

  final String icon;
  final String title;
  final bool available;
  final Color iconColor;
  final Color textColor;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TStyle.whiteBold(16, font: FFamily.roboto).copyWith(
            color: textColor,
            decoration: !available ? null : TextDecoration.lineThrough,
            decorationColor: textColor,
            decorationThickness: 1,
          ),
        ),
      ],
    );
  }
}
