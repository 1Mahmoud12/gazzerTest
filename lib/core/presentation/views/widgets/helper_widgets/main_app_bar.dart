import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
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
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      title: title == null ? null : Text(title!, style: titleStyle),
      leading: Navigator.canPop(context)
          ? IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: Icon(Icons.arrow_back_ios, color: bacButtonColor ?? Co.purple),
            )
          : null,
      leadingWidth: 65,
      actions: [
        if (showCart)
          Badge(
            label: const Text("0"),
            textColor: Co.mainText,
            backgroundColor: Co.second2,
            child: CartFloatingBtn(size: 20, padding: 8, navigate: !isCartScreen),
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

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
