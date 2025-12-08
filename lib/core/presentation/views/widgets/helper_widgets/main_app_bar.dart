import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
    this.showCart = false,
    this.iconsColor = Co.purple,
    this.isCartScreen = false,
    this.showLanguage = false,
    this.bacButtonColor,
    this.onShare,
    this.showNotification = false,
    this.title,
    this.backgroundColor,
    this.titleStyle,
    this.showBadge = false,
  });
  final bool showCart;
  final bool showLanguage;
  final bool showNotification;
  final Color iconsColor;
  final Color? bacButtonColor;
  final Color? backgroundColor;
  final bool isCartScreen;
  final Function()? onShare;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: backgroundColor,
      title: title == null ? null : Text(title!, style: TStyle.robotBlackTitle()),
      leadingWidth: Navigator.canPop(context) ? 65 : 0,
      actions: [
        if (showCart) MainCartWidget(size: 20, padding: 8, navigate: !isCartScreen, showBadge: showBadge),
        if (showNotification)
          IconButton(
            onPressed: () {},
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: SvgPicture.asset(Assets.assetsSvgNotification, height: 21, width: 21, colorFilter: ColorFilter.mode(iconsColor, BlendMode.srcIn)),
          ),
        if (showLanguage)
          IconButton(
            onPressed: () {},
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: SvgPicture.asset(Assets.assetsSvgLanguage, height: 21, width: 21, colorFilter: ColorFilter.mode(iconsColor, BlendMode.srcIn)),
          ),
        if (onShare != null)
          IconButton(
            onPressed: onShare,
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: const Icon(Icons.share, color: Co.purple, size: 24),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
