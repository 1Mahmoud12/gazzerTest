import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/name_logo_loyalty_program.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/our_tier_benefits_widget.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/progress_loyalty_program.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/widgets/your_points_widget.dart';

class LoyaltyProgramScreen extends StatefulWidget {
  const LoyaltyProgramScreen({super.key});

  static const route = '/loyalty-programs';

  @override
  State<LoyaltyProgramScreen> createState() => _LoyaltyProgramScreenState();
}

class _LoyaltyProgramScreenState extends State<LoyaltyProgramScreen> {
  final Color _mainColor = Co.purple;
  final Color firstTextColor = Co.white;
  final Color secondTextColor = Co.lightGrey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showCart: false,
        iconsColor: Co.secondary,
        title: L10n.tr().loyaltyProgram,
        titleStyle: TStyle.burbleMed(22, font: FFamily.roboto),
      ),

      body: Session().client == null
          ? Expanded(
              child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseLoyalty),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                const SizedBox(height: 16),
                Text(
                  'You’ve reached the top — you’re one of our elite customers!',
                  style: TStyle.blackMedium(16, font: FFamily.roboto),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                NameLogoLoyaltyProgram(
                  mainColor: _mainColor,
                  logo: Assets.assetsDeliveryLogo,
                  nameProgram: 'Hero',
                  firstTextColor: firstTextColor,
                  secondTextColor: secondTextColor,
                ),
                const SizedBox(height: 16),
                ProgressLoyaltyPrograms(
                  spentPoints: 500,
                  spendDuration: 90,
                  totalPoints: 2000,
                  maxProgramPoints: 2500,
                  mainColor: _mainColor,
                ),
                const SizedBox(height: 16),
                YourPointsWidget(
                  mainColor: _mainColor,
                  firstColorText: firstTextColor,
                  secondTextColor: secondTextColor,
                  availablePoints: 5400,
                  earningPoints: 100,
                  earningPerPound: 200,
                  conversionRate: 100,
                  conversionPound: 90,
                  expirationPoints: 55,
                  expirationDate: '30-10-2025',
                ),
                const SizedBox(height: 16),
                const OurTierBenefitsWidget(),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
