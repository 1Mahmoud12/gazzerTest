import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/alignment.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/image_in_nested_circles.dart';
import 'package:gazzer/core/presentation/views/widgets/products/rating_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/resturants/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_list_switche.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/cubit/restaurants_of_category_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_of_category/presentation/view/widgets/infinet_carousal.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

// components
part 'components/explore_best.dart';
part 'components/pick_to_you.dart';
part 'restaurants_of_category_screen.g.dart';

/// screen widgets
part 'widgets/add_widget.dart';
part 'widgets/type_related_restaurants_header.dart';

@TypedGoRoute<RestaurantsOfCategoryRoute>(path: RestaurantsOfCategoryScreen.routeUriId)
@immutable
class RestaurantsOfCategoryRoute extends GoRouteData with _$RestaurantsOfCategoryRoute {
  const RestaurantsOfCategoryRoute({required this.$extra});
  final CategoryOfPlateEntity $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<RestaurantsOfCategoryCubit>(param1: $extra.id),
      child: RestaurantsOfCategoryScreen(cat: $extra),
    );
  }
}

class RestaurantsOfCategoryScreen extends StatelessWidget {
  const RestaurantsOfCategoryScreen({super.key, required this.cat});
  final CategoryOfPlateEntity cat;
  static const routeUriId = '/cat-related-restaurant';

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RestaurantsOfCategoryCubit>();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return cubit.loadPageData();
        },
        child: ListView(
          padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
          children: [
            _TypeRelatedRestaurantsHeader(title: cat.name),

            const LongitudinalCarousal([
              Assets.assetsPngSandwitchLayers,
              Assets.assetsPngSandwtichLayer2,
              Assets.assetsPngSandwitchLayers,
              Assets.assetsPngSandwtichLayer2,
              Assets.assetsPngSandwitchLayers,
              Assets.assetsPngSandwtichLayer2,
            ]),

            BlocBuilder<RestaurantsOfCategoryCubit, RestaurantsOfCategoryStates>(
              buildWhen: (previous, current) => current is TopRatedStates,
              builder: (context, state) {
                if (state is TopRatedError) {
                  return FailureWidget(
                    message: state.error,
                    onRetry: () => cubit.getTopRatedSection(),
                  );
                }
                if (state is! TopRatedStates) return const SizedBox.shrink();
                final rest = state.restaurants;
                return Skeletonizer(
                  enabled: state is TopRatedLoading,
                  child: RestListSwitche(
                    style: CardStyle.typeTwo,
                    cardImageToTextRatios: {},
                    corners: {},
                    items: rest,
                    onViewAllPressed: null,
                    title: L10n.tr().topRated,
                    onSingleCardPressed: <RestaurantEntity>(item) {
                      print('asd asd a');
                    },
                  ),
                );
              },
            ),
            BlocBuilder<RestaurantsOfCategoryCubit, RestaurantsOfCategoryStates>(
              buildWhen: (previous, current) => current is OffersSectionStates,
              builder: (context, state) {
                if (state is OffersSectionError) {
                  return FailureWidget(
                    message: state.error,
                    onRetry: () => cubit.getOffersSection(),
                  );
                }
                if (state is! OffersSectionStates) return const SizedBox.shrink();
                final rest = state.restaurants;
                return Skeletonizer(
                  enabled: state is OffersSectionLoading,
                  child: RestListSwitche(
                    style: CardStyle.typeTwo,
                    cardImageToTextRatios: {},
                    corners: {},
                    items: rest,
                    onViewAllPressed: null,
                    title: L10n.tr().exploreBest,
                    onSingleCardPressed: <RestaurantEntity>(item) {
                      print('asd asd a');
                    },
                  ),
                );
              },
            ),
            BlocBuilder<RestaurantsOfCategoryCubit, RestaurantsOfCategoryStates>(
              buildWhen: (previous, current) => current is TodaysSickSectionStates,
              builder: (context, state) {
                if (state is TodaysSickSectionError) {
                  return FailureWidget(
                    message: state.error,
                    onRetry: () => cubit.getTodaysSickSection(),
                  );
                }
                if (state is! TodaysSickSectionStates) return const SizedBox.shrink();
                final rest = state.restaurants;
                return Skeletonizer(
                  enabled: state is TodaysSickSectionLoading,
                  child: RestListSwitche(
                    cardImageToTextRatios: {},
                    corners: {},
                    style: CardStyle.typeTwo,
                    title: L10n.tr().todayPicks,
                    items: rest,
                    onViewAllPressed: null,
                    onSingleCardPressed: <RestaurantEntity>(item) {
                      print('asd asd a');
                    },
                  ),
                );
              },
            ),
            BlocBuilder<RestaurantsOfCategoryCubit, RestaurantsOfCategoryStates>(
              buildWhen: (previous, current) => current is AllRestaurantsOfCategoryStates,
              builder: (context, state) {
                if (state is AllRestaurantsOfCategoryError) {
                  return FailureWidget(
                    message: state.error,
                    onRetry: () => cubit.getCategoryRelatedSection(),
                  );
                }
                if (state is! AllRestaurantsOfCategoryStates) return const SizedBox.shrink();
                final rest = state.restaurants;
                return Skeletonizer(
                  enabled: state is AllRestaurantsOfCategoryLoading,
                  child: RestListSwitche(
                    cardImageToTextRatios: {},
                    corners: {},
                    style: CardStyle.typeThree,
                    title: null,
                    items: rest,
                    onViewAllPressed: null,
                    onSingleCardPressed: <RestaurantEntity>(item) {
                      print('asd asd a');
                    },
                  ),
                );
              },
            ),
            // const _AddWidget(),
            // const _PickToYou(),
          ],
        ),
      ),
    );
  }
}
