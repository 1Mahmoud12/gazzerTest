import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/lists/restaurants_list_switche.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

// components
// part 'components/explore_best.dart';
// part 'components/pick_to_you.dart';
part 'restaurants_of_category_screen.g.dart';

/// screen widgets
// part 'widgets/add_widget.dart';
part 'widgets/type_related_restaurants_header.dart';

@TypedGoRoute<RestaurantsOfCategoryRoute>(path: RestaurantsOfCategoryScreen.routeUriId)
@immutable
class RestaurantsOfCategoryRoute extends GoRouteData with _$RestaurantsOfCategoryRoute {
  const RestaurantsOfCategoryRoute({required this.id});
  final int id;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<RestaurantsOfCategoryCubit>(param1: id),
      child: const RestaurantsOfCategoryScreen(),
    );
  }
}

class RestaurantsOfCategoryScreen extends StatelessWidget {
  const RestaurantsOfCategoryScreen({super.key});
  static const routeUriId = '/cat-related-restaurant';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantsOfCategoryCubit>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return cubit.loadPageData();
        },
        child: BlocBuilder<RestaurantsOfCategoryCubit, RestaurantsOfCategoryStates>(
          // buildWhen: (previous, current) => current is RestaurantsOfCategoryPageDataStates,
          builder: (context, state) {
            if (state is! RestaurantsOfCategoryPageDataStates) return const SizedBox.shrink();
            if (state is RestaurantsOfCategoryPageDataError) {
              return Column(
                children: [
                  const _TypeRelatedRestaurantsHeader(
                    title: '',
                  ),
                  Expanded(
                    child: FailureComponent(
                      message: L10n.tr().couldnotLoadDataPleaseTryAgain,
                      onRetry: () => cubit.loadPageData(),
                    ),
                  ),
                ],
              );
            }
            final banner = (state.banners.isEmpty ? Fakers.banners : state.banners).first;
            final lists = state.lists;
            final restaurants = state.restaurants;
            return Skeletonizer(
              enabled: state is RestaurantsOfCategoryPageDataLoading,
              child: ListView(
                padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
                children: [
                  _TypeRelatedRestaurantsHeader(title: state.name),

                  MainBannerWidget(banner: banner),
                  ...List.generate(
                    lists.length,
                    (index) {
                      return RestaurantsListSwitche(
                        style: lists[index].$2,
                        cardImageToTextRatios: {},
                        corners: {},
                        items: lists[index].$3,
                        onViewAllPressed: null,
                        title: lists[index].$1,
                        onSingleCardPressed: (item) {
                          RestaurantDetailsRoute(id: item.id).push(context);
                        },
                      );
                    },
                  ),

                  RestaurantsListSwitche(
                    cardImageToTextRatios: {},
                    corners: {},
                    style: CardStyle.typeThree,
                    title: null,
                    items: restaurants,
                    onViewAllPressed: null,
                    onSingleCardPressed: (item) {
                      RestaurantDetailsRoute(id: item.id).push(context);
                    },
                  ),

                  // const _AddWidget(),
                  // const _PickToYou(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
