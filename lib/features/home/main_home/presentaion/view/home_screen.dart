import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gazzer/core/data/dto/banner_dto.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/with_hot_spot.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/pkgs/floating_draggable_widget.dart';
import 'package:gazzer/core/presentation/pkgs/notification/notification.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/state_app_widget.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_bus.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';
import 'package:gazzer/features/home/homeViewAll/active_orders_widget/presentation/cubit/active_orders_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/best_popular_stores_widget/presentation/cubit/best_popular_stores_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/data/dtos/categories_widget_dto.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/categories_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/presentation/cubit/daily_offers_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/presentation/cubit/suggests_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/topItems/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/homeViewAll/top_items_widget/presentation/cubit/top_items_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/presentation/cubit/top_vendors_widget_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_cubit.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_states.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/all_categories_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/active_orders_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/best_popular_stores_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/categories_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/daily_offers_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/suggests_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/top_items_widget.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/sections/top_vendors_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/pharmacy_menu/pharmacy_menu_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/store_menu_switcher.dart';
import 'package:go_router/go_router.dart';
import 'package:hotspot/hotspot.dart' show HotspotProvider;
import 'package:shared_preferences/shared_preferences.dart';

///
///
part 'widgets/home_best_popular.dart';
part 'widgets/home_categories_widget.dart';
part 'widgets/home_header.dart';
part 'widgets/home_search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const route = '/';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  // Create cubits as instance variables so they persist and can be accessed
  late final CategoriesWidgetCubit _categoriesCubit;
  late final DailyOffersWidgetCubit _dailyOffersCubit;
  late final SuggestsWidgetCubit _suggestsCubit;
  late final TopVendorsWidgetCubit _topVendorsCubit;
  late final BestPopularStoresWidgetCubit _bestPopularStoresCubit;
  late final TopItemsWidgetCubit _topItemsCubit;
  late final ActiveOrdersWidgetCubit _activeOrdersCubit;

  @override
  void initState() {
    super.initState();
    // Initialize cubits
    _categoriesCubit = di<CategoriesWidgetCubit>()..getCategories();
    _dailyOffersCubit = di<DailyOffersWidgetCubit>()..getDailyOffers();
    _suggestsCubit = di<SuggestsWidgetCubit>()..getSuggests();
    _topVendorsCubit = di<TopVendorsWidgetCubit>()..getTopVendors();
    _bestPopularStoresCubit = di<BestPopularStoresWidgetCubit>()..getBestPopularStores();
    _topItemsCubit = di<TopItemsWidgetCubit>()..getTopItems();
    _activeOrdersCubit = di<ActiveOrdersWidgetCubit>()..getActiveOrders();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      //context.read<HomeCubit>().getHomeData();
      // AppNavigator().initContext = context;
      if (Session().showTour) {
        HotspotProvider.of(context).startFlow();
        di<SharedPreferences>().setBool(StorageKeys.haveSeenTour, true);
      }
    });

    LifecycleEventHandler(
      resumeCallBack: () async {
        _refreshAllWidgets(isRefresh: false);
      },
    );
  }

  @override
  void dispose() {
    _categoriesCubit.close();
    _dailyOffersCubit.close();
    _suggestsCubit.close();
    _topVendorsCubit.close();
    _bestPopularStoresCubit.close();
    _topItemsCubit.close();
    _activeOrdersCubit.close();
    super.dispose();
  }

  Future<void> _refreshAllWidgets({bool isRefresh = true}) async {
    if (isRefresh) animationDialogLoading();
    await Future.wait([
      _categoriesCubit.getCategories(),
      _dailyOffersCubit.getDailyOffers(),
      _suggestsCubit.getSuggests(),
      _activeOrdersCubit.getActiveOrders(),
      _topVendorsCubit.getTopVendors(),
      _bestPopularStoresCubit.getBestPopularStores(),
      _topItemsCubit.getTopItems(),
    ]);
    if (isRefresh) closeDialog();
  }

  int exitApp = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    selectTokens();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        exitApp++;
        //Utils.showToast(title: 'swipe twice to exit', state: UtilState.success);
        Alerts.showToast(L10n.tr().swipeTwiceToExit, error: false, isInfo: true, toastGravity: ToastGravity.CENTER);
        Future.delayed(const Duration(seconds: 5), () {
          exitApp = 0;
          setState(() {});
        });
        if (exitApp == 2) {
          exit(0);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) => Scaffold(
          // floatingActionButtonLocation: CustomFloatingBtnPosition(
          //   HomeUtils.headerHeight(context) + 12,
          //   50 + AppConst.defaultHrPadding.right,
          // ),
          // floatingActionButton: const CartFloatingBtn(),
          body: FloatingDraggableWidget(
            // dragLimit: DragLimit(bottom: MediaQuery.sizeOf(context).height - constraints.maxHeight),
            floatingWidget: const SizedBox(),
            floatingWidgetHeight: 50,
            floatingWidgetWidth: 50,
            speed: 1,
            dy: HomeUtils.headerHeight(context) + 12,
            dx: L10n.isAr(context) ? AppConst.defaultHrPadding.right : constraints.maxWidth - (50 + AppConst.defaultHrPadding.right),
            disableBounceAnimation: true,
            mainScreenWidget: MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _categoriesCubit),
                BlocProvider.value(value: _dailyOffersCubit),
                BlocProvider.value(value: _suggestsCubit),
                BlocProvider.value(value: _topVendorsCubit),
                BlocProvider.value(value: _bestPopularStoresCubit),
                BlocProvider.value(value: _topItemsCubit),
                BlocProvider.value(value: _activeOrdersCubit),
              ],
              child: BlocBuilder<HomeCubit, HomeStates>(
                builder: (context, state) {
                  return RefreshIndicator(
                    onRefresh: _refreshAllWidgets,
                    child: const CustomScrollView(
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(padding: EdgeInsets.only(bottom: 12), child: _HomeHeader()),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(padding: EdgeInsets.only(bottom: 24), child: _HomeSearchWidget()),
                        ),

                        ///
                        CategoriesWidget(),

                        ///
                        ActiveOrdersWidget(),

                        ///
                        DailyOffersWidget(),

                        ///
                        SuggestsWidget(),

                        // ///
                        TopVendorsWidget(),

                        // ///
                        BestPopularStoresWidget(),

                        // ///
                        TopItemsWidget(),
                        SliverToBoxAdapter(child: VerticalSpacing(100)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
