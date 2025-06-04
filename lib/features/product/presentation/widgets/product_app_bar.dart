import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';

class ProductAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      actions: [
        const Badge(
          label: Text("0"),
          textColor: Co.mainText,
          backgroundColor: Co.second2,
          child: CartFloatingBtn(size: 20, padding: 8),
        ),
        const HorizontalSpacing(12),
        SvgPicture.asset(
          Assets.assetsSvgNotification,
          height: 24,
          width: 24,
          colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
        ),
        const HorizontalSpacing(12),
        SvgPicture.asset(
          Assets.assetsSvgLanguage,
          height: 24,
          width: 24,
          colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
