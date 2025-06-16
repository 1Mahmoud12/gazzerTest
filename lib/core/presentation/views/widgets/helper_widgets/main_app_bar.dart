import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({super.key, this.showCart = true, this.iconsColor = Co.purple});
  final bool showCart;
  final Color iconsColor;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actionsPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back_ios)),
      leadingWidth: 65,
      actions: [
        if (showCart)
          const Badge(
            label: Text("0"),
            textColor: Co.mainText,
            backgroundColor: Co.second2,
            child: CartFloatingBtn(size: 20, padding: 8),
          ),
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
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
