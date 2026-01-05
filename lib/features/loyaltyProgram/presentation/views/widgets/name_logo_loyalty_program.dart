import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class NameLogoLoyaltyProgram extends StatelessWidget {
  const NameLogoLoyaltyProgram({
    super.key,
    required this.mainColor,
    required this.logo,
    required this.nameProgram,
    required this.firstTextColor,
    required this.secondTextColor,
  });

  final Color mainColor;
  final String logo;
  final String nameProgram;
  final Color firstTextColor;
  final Color secondTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: [
          SvgPicture.asset(logo, width: 64, height: 64),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(L10n.tr().yourLoyaltyJourney, style: TStyle.robotBlackMedium().copyWith(color: firstTextColor)),
              Text('${L10n.tr().level}: $nameProgram', style: TStyle.robotBlackMedium().copyWith(color: secondTextColor)),
            ],
          ),
        ],
      ),
    );
  }
}
