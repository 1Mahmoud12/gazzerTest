import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/with_hot_spot.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/dailyOffers/presentation/daily_offers_screen.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_cubit.dart';
import 'package:gazzer/features/home/best_popular/presentation/views/best_popular_screen.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/home_categories/suggested/presentation/view/suggested_screen.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_states.dart';
import 'package:gazzer/features/home/top_vendors/presentation/top_vendors_screen.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/pharmacy_menu/pharmacy_menu_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/store_menu_switcher.dart';
import 'package:go_router/go_router.dart';
import 'package:hotspot/hotspot.dart' show HotspotProvider;
import 'package:shared_preferences/shared_preferences.dart';

///
///
part 'widgets/home_best_popular.dart';
part 'widgets/home_best_popular_stores.dart';
part 'widgets/home_categories_widget.dart';
part 'widgets/home_cuisines_widget.dart';
part 'widgets/home_daily_offers_widget.dart';
part 'widgets/home_header.dart';
part 'widgets/home_search_widget.dart';
part 'widgets/home_suggested_products_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getHomeData();
      // AppNavigator().initContext = context;
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
        extendBody: false,
        extendBodyBehindAppBar: false,
        // floatingActionButtonLocation: CustomFloatingBtnPosition(
        //   HomeUtils.headerHeight(context) + 12,
        //   50 + AppConst.defaultHrPadding.right,
        // ),
        // floatingActionButton: const CartFloatingBtn(),
        body: FloatingDraggableWidget(
          // dragLimit: DragLimit(bottom: MediaQuery.sizeOf(context).height - constraints.maxHeight),
          floatingWidget: const MainCartWidget(
            showBadge: true,
          ).withHotspot(order: 3, title: "", text: L10n.tr().checkYourCart),
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
                  return FailureComponent(
                    message: state.msg,
                    onRetry: () async {
                      await context.read<HomeCubit>().getHomeData();
                    },
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return context.read<HomeCubit>().getHomeData();
                    },
                    child: CustomScrollView(
                      slivers: [
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: _HomeHeader(),
                          ),
                        ),
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 24),
                            child: _HomeSearchWidget(),
                          ),
                        ),

                        ///
                        _HomeCategoriesComponent(
                          items: state.homeResponse?.categories ?? [],
                        ),
                        if (state.homeResponse?.categoriesBanner != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: MainBannerWidget(
                                banner: state.homeResponse!.categoriesBanner!,
                              ),
                            ),
                          ),

                        // ///
                        _DailyOffersWidget(
                          items: state.homeResponse?.dailyOffers ?? <GenericItemEntity>[],
                        ),
                        if (state.homeResponse?.dailyOffersBanner != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),

                              child: MainBannerWidget(
                                banner: state.homeResponse!.dailyOffersBanner!,
                              ),
                            ),
                          ),

                        // /// const SummerSaleAddWidget(),
                        _HomeSuggestedProductsWidget(
                          items: state.homeResponse?.suggested ?? <GenericItemEntity>[],
                        ),
                        if (state.homeResponse?.suggestedBanner != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),

                              child: MainBannerWidget(
                                banner: state.homeResponse!.suggestedBanner!,
                              ),
                            ),
                          ),

                        // ///
                        _HomeTopVendorsWidget(
                          vendors: state.homeResponse?.topVendors ?? <VendorEntity>[],
                        ),
                        if (state.homeResponse?.topVendorsBanner != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: MainBannerWidget(
                                banner: state.homeResponse!.topVendorsBanner!,
                              ),
                            ),
                          ),

                        // ///
                        _HomeBestPopularStoresWidget(
                          stores: state.homeResponse?.bestPopular ?? <VendorEntity>[],
                        ),
                        if (state.homeResponse?.bestPopularBanner != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: MainBannerWidget(
                                banner: state.homeResponse!.bestPopularBanner!,
                              ),
                            ),
                          ),

                        // ///
                        _HomeBestPopular(
                          items: state.homeResponse?.topItems ?? <GenericItemEntity>[],
                        ),
                        if (state.homeResponse?.bestPopularBanner != null)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: MainBannerWidget(
                                banner: state.homeResponse!.bestPopularBanner!,
                              ),
                            ),
                          ),
                        // _HomeTopItems(
                        //   items: state.homeResponse?.topItems ?? <GenericItemEntity>[],
                        // ),
                        // if (state.homeResponse?.topItems != null)
                        //   SliverToBoxAdapter(
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(bottom: 24),
                        //       child: MainBannerWidget(
                        //         banner: state.homeResponse!.topItemsBanner!,
                        //       ),
                        //     ),
                        //   ),

                        // const ImageWithAlignedBtn(image: Assets.assetsPngHomeAdd, align: Alignment(0, 1), btnText: "Order Now"),
                      ],
                    ),
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
