import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:go_router/go_router.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(),
        DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: Grad().bglightLinear,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Image.asset(
              Assets.assetsGifCart,
              height: 175,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          L10n.tr().yourCartIsEmpty,
          style: TStyle.primaryBold(16),
        ),
        const SizedBox.shrink(),
        MainBtn(
          onPressed: () {
            context.go(HomeScreen.route);
          },
          bgColor: Co.secondary,
          width: 250,
          radius: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 12,
            children: [
              SvgPicture.asset(
                Assets.assetsSvgCart,
                height: 24,
                colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
              ),
              Text(
                L10n.tr().startShopping,
                style: TStyle.primaryBold(14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
