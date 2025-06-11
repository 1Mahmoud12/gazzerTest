import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/widgets/products/mini_product_card.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/utils/home_utils.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_add_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_best_popular.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_button_offer_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_categories_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_contact_us_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_cuisines_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_daily_offers_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_header.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_search_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/home_suggested_products_widget.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/summer_sale_add_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        // floatingActionButtonLocation: CustomFloatingBtnPosition(
        //   HomeUtils.headerHeight(context) + 12,
        //   50 + AppConst.defaultHrPadding.right,
        // ),
        // floatingActionButton: const CartFloatingBtn(),
        body: FloatingDraggableWidget(
          dragLimit: DragLimit(bottom: MediaQuery.sizeOf(context).height - constraints.maxHeight),
          floatingWidget: const CartFloatingBtn(),
          floatingWidgetHeight: 50,
          floatingWidgetWidth: 50,
          autoAlign: false,
          autoAlignType: AlignmentType.both,
          speed: 1,
          dy: HomeUtils.headerHeight(context) + 12,
          dx: constraints.maxWidth - (50 + AppConst.defaultHrPadding.right),
          disableBounceAnimation: true,
          mainScreenWidget: ListView(
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
                      rtChild: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GradientText(
                            text: "Free Delivery",
                            style: TStyle.blackBold(22),
                            gradient: Grad.radialGradient,
                          ),
                          GradientText(
                            text: "Earn Your First 5 Orders",
                            style: TStyle.blackBold(16),
                            gradient: Grad.radialGradient,
                          ),
                          GradientText(
                            text: "FREE",
                            style: TStyle.blackBold(18).copyWith(letterSpacing: 12),
                            gradient: Grad.radialGradient,
                          ),
                        ],
                      ),
                    ),
                    const DailyOffersWidget(),
                    const SummerSaleAddWidget(),
                    //
                    const HomeSuggestedProductsWidget(),
                    HomeDoubleAddWidget(
                      bgColor: const Color(0x88B8ABEA),
                      fgColor: const Color(0x88FFC4C4),
                      ltChild: Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GradientText(text: "Top Rated", style: TStyle.blackBold(20), gradient: Grad.radialGradient),
                            Text("Explore", style: TStyle.blackBold(14)),
                          ],
                        ),
                      ),
                      rtChild: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: 5,
                        separatorBuilder: (context, index) => const HorizontalSpacing(12),
                        itemBuilder: (context, index) {
                          return MiniProductCard(product: Fakers.fakeProds[index]);
                        },
                      ),
                    ),
                    const HomeCuisinesWidget(),
                    const HomeContactUsWidget(),
                    const HomeBestPopular(),
                    const HomeButtonOfferWidget(),
                    const VerticalSpacing(8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
