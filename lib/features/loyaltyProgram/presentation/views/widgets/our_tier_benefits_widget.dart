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
              ProgramWidget(),
              ProgramWidget(),
              ProgramWidget(),
            ],
          ),
        ),
      ],
    );
  }
}

class ProgramWidget extends StatelessWidget {
  const ProgramWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Co.purple600,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hero tier benefits',
            style: TStyle.whiteBold(20, font: FFamily.roboto),
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgBirthdayIc,
            title: L10n.tr().birthdayVouchers,
            available: true,
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgOfferIc,
            title: L10n.tr().exclusiveDeals,
            available: false,
          ),
          const SizedBox(height: 16),
          TierRowWidget(
            icon: Assets.assetsSvgOfferIc,
            title: L10n.tr().exclusiveOffers,
            available: false,
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
  });

  final String icon;
  final String title;
  final bool available;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(color: Co.purple100, shape: BoxShape.circle),
          child: SvgPicture.asset(icon),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TStyle.whiteBold(16, font: FFamily.roboto).copyWith(
            decoration: !available ? null : TextDecoration.lineThrough,
            decorationColor: Co.white,
            decorationThickness: 1,
          ),
        ),
      ],
    );
  }
}
