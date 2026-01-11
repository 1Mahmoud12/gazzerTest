import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/cubits/app_settings_cubit.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_back_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:http/http.dart';

class AppBarRowWidget extends StatelessWidget {
  const AppBarRowWidget({
    super.key,
    this.showCart = false,
    this.iconsColor = Co.purple,
    this.isCartScreen = false,
    this.showLanguage = false,
    this.bacButtonColor,
    this.backgroundColor,
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
  final Color? backgroundColor;
  final bool isCartScreen;
  final Function()? onShare;
  final String? title;
  final TextStyle? titleStyle;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {

 final isDarkMode = context.read<AppSettingsCubit>().state.isDarkMode;
    print('isDarkMode $isDarkMode');
    final iconsColor1 = isDarkMode ? Colors.white : iconsColor;   


    return Container(
      color: backgroundColor,
      child: Row(
        spacing: 18,
        children: [
          MainBackIcon(color: bacButtonColor),

          const Spacer(),
          if (showCart)
            MainCartWidget(size: 20, padding: 8, showBadge: showBadge),

          if (showNotification)
            IconButton(
              onPressed: () {},
              // style: IconButton.styleFrom(backgroundColor: Colors.black12),
              icon: SvgPicture.asset(
                Assets.assetsSvgNotification,
                height: 21,
                width: 21,
                colorFilter: ColorFilter.mode(iconsColor1, BlendMode.srcIn),
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
                colorFilter: ColorFilter.mode(iconsColor1, BlendMode.srcIn),
              ),
            ),
          if (onShare != null)
            IconButton(
              onPressed: onShare,
              // style: IconButton.styleFrom(backgroundColor: Colors.black12),
              icon: const Icon(Icons.share, color: Co.purple, size: 24),
            ),
        ],
      ),
    );
  }
}
