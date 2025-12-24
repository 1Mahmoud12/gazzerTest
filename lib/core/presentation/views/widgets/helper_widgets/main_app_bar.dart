import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';

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
    this.onBack,
    this.showBadge = false,
    this.showLeading = true,
  });
  final bool showCart;
  final bool showLanguage;
  final bool showNotification;
  final Color iconsColor;
  final Color? bacButtonColor;
  final Color? backgroundColor;
  final bool isCartScreen;
  final Function()? onShare;
  final Function()? onBack;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBadge;
  final bool showLeading;

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final shouldShowLeading = showLeading && (canPop || onBack != null);

    return AppBar(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: backgroundColor,
      title: title == null ? null : Text(title!, style: titleStyle ?? TStyle.robotBlackTitle().copyWith(color: Co.purple)),
      leadingWidth: shouldShowLeading ? 65 : 0,
      leading: shouldShowLeading
          ? IconButton(
              onPressed: onBack ?? () => Navigator.pop(context),
              icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back, color: Co.black),
            )
          : null,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      actions: [
        if (showCart) MainCartWidget(size: 20, padding: 8, navigate: !isCartScreen, showBadge: showBadge),
        if (showNotification)
          IconButton(
            onPressed: () {},
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: VectorGraphicsWidget(
              Assets.assetsSvgNotification,
              height: 21,
              width: 21,
              colorFilter: ColorFilter.mode(iconsColor, BlendMode.srcIn),
            ),
          ),
        if (showLanguage)
          IconButton(
            onPressed: () {},
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: VectorGraphicsWidget(Assets.assetsSvgLanguage, height: 21, width: 21, colorFilter: ColorFilter.mode(iconsColor, BlendMode.srcIn)),
          ),
        if (onShare != null)
          IconButton(
            onPressed: onShare,
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: const VectorGraphicsWidget(Assets.shareIc),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
