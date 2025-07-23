import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';

class AppBarRowWidget extends StatelessWidget {
  const AppBarRowWidget({
    super.key,
    this.showCart = false,
    this.showLanguage = false,
    this.iconsColor = Co.purple,
    this.bacButtonColor = Co.purple,
  });
  final bool showCart;
  final bool showLanguage;
  final Color iconsColor;
  final Color bacButtonColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 18,
      children: [
        IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: Icon(Icons.arrow_back_ios, color: bacButtonColor),
        ),
        const Spacer(),
        if (showCart)
          Badge(
            label: const Text("0"),
            textColor: Co.mainText,
            backgroundColor: Co.second2,
            child: CartFloatingBtn(size: 20, padding: 8, navigate: true),
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
      ],
    );
  }
}
