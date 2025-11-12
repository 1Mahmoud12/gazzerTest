import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_switcher.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/drawer/views/widgets/drawer_btn.dart';
import 'package:gazzer/features/favorites/presentation/views/favorites_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/video_tutorial_screen.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/loyalty_program_gainer_three.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/loyalty_program_hero_one.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/loyalty_program_silver_three.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/loyalty_program_winner_two.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late final List<(String, Object, Function)> drawerBtns;

  @override
  void initState() {
    drawerBtns = [
      (L10n.tr().myCart, Assets.assetsSvgCart, (BuildContext ctx) => ctx.push(CartScreen.route)),
      (
        L10n.tr().themeMode,
        Switch(value: true, onChanged: (v) {}).withScale(scale: 0.8, alignment: Alignment.centerRight),
        (BuildContext ctx) {},
      ),
      (L10n.tr().foodPlan, Assets.assetsSvgFoodPlan, (BuildContext ctx) => ctx.push(HealthFocusScreen.route)),
      (
        L10n.tr().videoTutorials,
        Assets.assetsSvgVideo,
        (BuildContext ctx) => ctx.push(VideoTutorialScreen.route),
      ),
      (L10n.tr().rewards, Assets.assetsSvgRewards, (BuildContext ctx) {}),
      (
        L10n.tr().favorites,
        Assets.assetsSvgFavoritesOutlined,
        (BuildContext ctx) {
          ctx.pushReplacement(FavoritesScreen.route);
        },
      ),
      (L10n.tr().myOrders, Assets.assetsSvgHistory, (BuildContext ctx) {}),
      (L10n.tr().language, Assets.assetsSvgLanguage, (BuildContext ctx) {}),
      (L10n.tr().gazzerChat, Assets.assetsSvgChat, (BuildContext ctx) {}),
      (
        L10n.tr().myProfile,
        Assets.assetsSvgCommunity,
        (BuildContext ctx) {
          ctx.push(ProfileScreen.route);
        },
      ),
      (L10n.tr().paymentSetting, Assets.assetsSvgPaymentSettings, (BuildContext ctx) {}),
      (L10n.tr().termsAndConditions, Assets.assetsSvgTerms, (BuildContext ctx) {}),
      (
        '1',
        Assets.assetsSvgTerms,
        (BuildContext ctx) {
          ctx.push(LoyaltyProgramHeroOneScreen.route);
        },
      ),
      (
        '2',
        Assets.assetsSvgTerms,
        (BuildContext ctx) {
          ctx.push(LoyaltyProgramWinnerTwoScreen.route);
        },
      ),
      (
        '3',
        Assets.assetsSvgTerms,
        (BuildContext ctx) {
          ctx.push(LoyaltyProgramSilverThreeScreen.route);
        },
      ),
      (
        '4',
        Assets.assetsSvgTerms,
        (BuildContext ctx) {
          ctx.push(LoyaltyProgramGainerFourScreen.route);
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.only(
          topLeft: Radius.circular(L10n.isAr(context) ? 0 : 44),
          bottomLeft: Radius.circular(L10n.isAr(context) ? 0 : 44),
          topRight: Radius.circular(L10n.isAr(context) ? 44 : 0),
          bottomRight: Radius.circular(L10n.isAr(context) ? 44 : 0),
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: Grad().bglightLinear.copyWith(
            colors: [Co.buttonGradient.withAlpha(180), Colors.black.withAlpha(0)],
          ),
        ),
        child: Column(
          children: [
            DrawerHeader(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GradientText(text: L10n.tr().gazzerApp, style: TStyle.primaryBold(24)),
                  SvgPicture.asset(
                    Assets.assetsSvgDrawerIcon,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                  ),
                ],
              ),
            ),
            const VerticalSpacing(4),
            Expanded(
              child: ListView.separated(
                itemCount: drawerBtns.length,
                padding: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.paddingOf(context).bottom + 24),
                separatorBuilder: (context, index) => const VerticalSpacing(12),
                itemBuilder: (context, index) {
                  final (title, svgImg, onTap) = drawerBtns[index];
                  return DrawerBtn(
                    title: title,
                    svgImg: svgImg is String ? svgImg : null,
                    icon: svgImg is! String ? (svgImg as Widget) : null,
                    onTap: (ctx) => onTap(ctx),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(bottom: MediaQuery.paddingOf(context).bottom),
              child: FutureBuilder(
                future: ShorebirdUpdater().readCurrentPatch(),
                builder: (context, snapshot) {
                  final info = di<PackageInfo>();
                  return Text(
                    'V${info.version}+${info.buildNumber} (${snapshot.data?.number ?? 0})',
                    style: TStyle.blackSemi(12),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
