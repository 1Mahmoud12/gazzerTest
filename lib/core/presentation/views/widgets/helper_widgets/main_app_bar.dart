import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  MainAppBar({
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
    this.widgetAction,
    this.toolbarHeight = kToolbarHeight,
  });
  final bool showCart;
  final bool showLanguage;
  final bool showNotification;
  Color iconsColor;
  final Color? bacButtonColor;
  final Color? backgroundColor;
  final bool isCartScreen;
  final Function()? onShare;
  final Function()? onBack;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBadge;
  final bool showLeading;
  final double toolbarHeight;
  final Widget? widgetAction;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    iconsColor = isDarkMode ? Colors.white : iconsColor;
    final canPop = Navigator.canPop(context);
    final shouldShowLeading = showLeading && (canPop || onBack != null);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Co.bg,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    return AppBar(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      backgroundColor: backgroundColor,
      title: title == null
          ? null
          : Text(title!, style: titleStyle ?? context.style24500),
      leadingWidth: shouldShowLeading ? 65 : 0,
      leading: shouldShowLeading
          ? IconButton(
              onPressed: onBack ?? () => Navigator.pop(context),
              icon: Icon(
                Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                color: Co.black,
              ),
            )
          : null,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Co.bg,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      actions: [
        if (showCart)
          MainCartWidget(
            size: 20,
            padding: 8,
            navigate: !isCartScreen,
            showBadge: showBadge,
          ),
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
            icon: VectorGraphicsWidget(
              Assets.assetsSvgLanguage,
              height: 21,
              width: 21,
              colorFilter: ColorFilter.mode(iconsColor, BlendMode.srcIn),
            ),
          ),
        if (onShare != null)
          IconButton(
            onPressed: onShare,
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: const VectorGraphicsWidget(Assets.shareIc),
          ),
        if (widgetAction != null) widgetAction!,
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
