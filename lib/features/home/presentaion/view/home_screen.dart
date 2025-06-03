import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/utils/custom_floating_btn_position.dart';
import 'package:gazzer/features/home/presentaion/utils/home_utils.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/cart_floating_btn.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/categories_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/daily_offers_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_add_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_header.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_search_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_suggested_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: CustomFloatingBtnPosition(
        HomeUtils.headerHeight(context) + 12,
        50 + AppConst.defaultHrPadding.right,
      ),
      floatingActionButton: const CartFloatingBtn(),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const HomeHeader(),
          const VerticalSpacing(12),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: Column(
              spacing: 24,
              children: [
                const HomeSearchWidget(),
                const CategoriesWidget(),
                HomeAddWidget(
                  color: const Color(0xAAB8ABEA),
                  image: Assets.assetsLottieDeliveryBoy,
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientText(text: "Free Delivery", style: TStyle.blackBold(32), gradient: Grad.radialGradient),
                      GradientText(
                        text: "Earn Your First 5 Orders",
                        style: TStyle.blackBold(18),
                        gradient: Grad.radialGradient,
                      ),
                      GradientText(
                        text: "FREE",
                        style: TStyle.blackBold(24).copyWith(letterSpacing: 12),
                        gradient: Grad.radialGradient,
                      ),
                    ],
                  ),
                ),
                const DailyOffersWidget(),
                HomeAddWidget(
                  color: const Color(0x66FFC4C4),
                  image: Assets.assetsSvgDiscount,
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientText(
                        text: "Mega Summer\nSale",
                        style: TStyle.blackBold(32),
                        gradient: Grad.radialGradient,
                      ),

                      Text("deals starts 27 may", style: TStyle.blackBold(16)),
                    ],
                  ),
                ),
                HomeSuggestedProductsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
