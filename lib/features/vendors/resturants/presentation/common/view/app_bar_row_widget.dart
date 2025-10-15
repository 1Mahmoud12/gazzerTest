import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_back_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';

class AppBarRowWidget extends StatelessWidget {
  const AppBarRowWidget({
    super.key,
    this.showCart = false,
    this.iconsColor = Co.purple,
    this.isCartScreen = false,
    this.showLanguage = false,
    this.bacButtonColor,
    this.onShare,
    this.showNotification = true,
    this.title,
    this.titleStyle,
    this.showBadge = false,
  });
  final bool showCart;
  final bool showLanguage;
  final bool showNotification;
  final Color iconsColor;
  final Color? bacButtonColor;
  final bool isCartScreen;
  final Function()? onShare;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 18,
      children: [
        const MainBackIcon(),

        const Spacer(),
        if (showCart)
          MainCartWidget(
            size: 20,
            padding: 8,
            navigate: true,
            showBadge: showBadge,
          ),

        if (showNotification)
          IconButton(
            onPressed: () {},
            // style: IconButton.styleFrom(backgroundColor: Colors.black12),
            icon: SvgPicture.asset(
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
            icon: SvgPicture.asset(
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
            icon: const Icon(Icons.share, color: Co.purple, size: 24),
          ),
      ],
    );
  }
}
