import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_switcher.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/drawer/views/widgets/drawer_btn.dart';
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/video_tutorial_screen.dart';
import 'package:gazzer/features/profile/presentation/views/profile_screen.dart';
import 'package:go_router/go_router.dart';

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
          // LayoutInherited.of(context).changeIndex(1);
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
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(44)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: Grad().bglightLinear.copyWith(colors: [Co.buttonGradient.withAlpha(180), Colors.black.withAlpha(0)]),
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
          ],
        ),
      ),
    );
  }
}
