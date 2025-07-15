import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/domain/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/with_hot_spot.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/routing/custom_page_transition_builder.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_bunner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/adds/image_with_aligned_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/spiky_shape_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
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
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/home_categories/daily_offers/presentation/view/daily_offers_screen.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/home_categories/suggested_screen/presentation/view/suggested_screen.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_states.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/search/presentaion/view/search_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu.dart';
import 'package:hotspot/hotspot.dart' show HotspotProvider;
import 'package:shared_preferences/shared_preferences.dart';

///
///
part 'widgets/home_best_popular.dart';
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
      context.read<HomeCubit>().getHomeData();
      AppNavigator().initContext = context;
      if (Session().showTour) {
        HotspotProvider.of(context).startFlow();
        di<SharedPreferences>().setBool(StorageKeys.haveSeenTour, true);
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
          floatingWidget: const CartFloatingBtn().withHotspot(order: 3, title: "", text: L10n.tr().checkYourCart),
          floatingWidgetHeight: 50,
          floatingWidgetWidth: 50,
          autoAlign: false,
          autoAlignType: AlignmentType.both,
          speed: 1,
          dy: HomeUtils.headerHeight(context) + 12,
          dx: L10n.isAr(context) ? AppConst.defaultHrPadding.right : constraints.maxWidth - (50 + AppConst.defaultHrPadding.right),
          disableBounceAnimation: true,
          mainScreenWidget: RefreshIndicator(
            onRefresh: () async {
              await context.read<HomeCubit>().getHomeData();
            },
            child: BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                if (state is! HomeDataStates) return const SizedBox.shrink();
                if (state is HomeDataLoadingState) {
                  return const Center(child: AdaptiveProgressIndicator());
                } else if (state is HomeDataErrorState) {
                  return FailureWidget(
                    message: state.msg,
                    onRetry: () async {
                      await context.read<HomeCubit>().getHomeData();
                    },
                  );
                } else {
                  return ListView(
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
                            _HomeCategoriesComponent(
                              data: state.homeResponse?.categories?.$1 ?? [],
                              banner: state.homeResponse?.categories?.$2,
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
                                    Align(alignment: Alignment.topLeft, child: Image.asset(Assets.assetsGifWow, width: 65)),
                                    GradientText(text: L10n.tr().topRated, style: TStyle.blackBold(20), gradient: Grad().radialGradient),
                                    Text(L10n.tr().explore, style: TStyle.blackBold(14)),
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
                            const VerticalSpacing(8),
                          ],
                        ),
                      ),
                      const ImageWithAlignedBtn(image: Assets.assetsPngHomeAdd, align: Alignment(0, 1), btnText: "Order Now"),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
