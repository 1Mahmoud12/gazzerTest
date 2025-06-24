import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/data/session.dart';
import 'package:gazzer/core/domain/category/category_model.dart';
import 'package:gazzer/core/presentation/extensions/with_hot_spot.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/spiky_shape_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/products/mini_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/core/presentation/views/widgets/summer_sale_add_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/home/home_categories/daily_offers/presentation/view/daily_offers_screen.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/home_categories/suggested_screen/presentation/view/suggested_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/restaurants_menu.dart';
import 'package:hotspot/hotspot.dart' show HotspotProvider;

///
///
part 'widgets/home_best_popular.dart';
part 'widgets/home_button_offer_widget.dart';
part 'widgets/home_categories_widget.dart';
part 'widgets/home_contact_us_widget.dart';
part 'widgets/home_cuisines_widget.dart';
part 'widgets/home_daily_offers_widget.dart';
part 'widgets/home_header.dart';
part 'widgets/home_search_widget.dart';
part 'widgets/home_suggested_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Session().showTour) {
        HotspotProvider.of(context).startFlow();
      }
    });
    super.initState();
  }

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
          floatingWidget: const CartFloatingBtn().withHotspot(order: 3, title: "", text: "Check Your Cart"),
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
              const _HomeHeader(),
              const VerticalSpacing(12),
              Padding(
                padding: AppConst.defaultHrPadding,
                child: Column(
                  spacing: 24,
                  children: [
                    const _HomeSearchWidget(),
                    const _HomeCategoriesWidget(),
                    SpikyShapeWidget(
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
                          Text.rich(
                            TextSpan(
                              children: [
                                const TextSpan(text: "Earn Your First"),
                                TextSpan(text: " 5 ", style: TStyle.blackBold(17)),
                                const TextSpan(text: "Orders"),
                              ],
                            ),
                            style: TStyle.blackBold(15),
                          ),
                          // GradientText(
                          //   text: "Earn Your First 5 Orders",
                          //   style: TStyle.blackBold(16),
                          //   gradient: Grad.radialGradient,
                          // ),
                          GradientText(
                            text: "FREE",
                            style: TStyle.blackBold(18).copyWith(letterSpacing: 12),
                            gradient: Grad.radialGradient,
                          ),
                        ],
                      ),
                    ),
                    const _DailyOffersWidget(),
                    const SummerSaleAddWidget(),
                    //
                    const _HomeSuggestedProductsWidget(),
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
                    const _HomeCuisinesWidget(),
                    const _HomeContactUsWidget(),
                    const _HomeBestPopular(),
                    const _HomeButtonOfferWidget(),
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
