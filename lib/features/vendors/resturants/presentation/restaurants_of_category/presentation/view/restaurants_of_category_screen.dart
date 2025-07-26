import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/extensions/alignment.dart';
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
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_horz_scroll_vert_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_vert_scroll_horz_card_list_component.dart';
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
part 'components/today_picks_widget.dart';
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

class RestaurantsOfCategoryScreen extends StatefulWidget {
  const RestaurantsOfCategoryScreen({super.key, required this.cat});
  final CategoryOfPlateEntity cat;
  static const routeUriId = '/cat-related-restaurant';

  @override
  State<RestaurantsOfCategoryScreen> createState() => _RestaurantsOfCategoryScreenState();
}

class _RestaurantsOfCategoryScreenState extends State<RestaurantsOfCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
        children: [
          _TypeRelatedRestaurantsHeader(title: widget.cat.name),

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
                  onRetry: () => context.read<RestaurantsOfCategoryCubit>().getTopRatedSection(),
                );
              }
              if (state is! TopRatedStates) return const SizedBox.shrink();
              final rest = state.restaurants;
              return Skeletonizer(
                enabled: state is TopRatedLoading,
                child: RestVertScrollHorzCardListComponent(
                  items: rest,
                  onViewAllPressed: null,
                  title: L10n.tr().exploreBest,
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
                  onRetry: () => context.read<RestaurantsOfCategoryCubit>().getOffersSection(),
                );
              }
              if (state is! OffersSectionStates) return const SizedBox.shrink();
              final rest = state.restaurants;
              return Skeletonizer(
                enabled: state is OffersSectionLoading,
                child: RestVertScrollHorzCardListComponent(
                  items: rest,
                  onViewAllPressed: null,
                  title: L10n.tr().exploreBest,
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
                  onRetry: () => context.read<RestaurantsOfCategoryCubit>().getTodaysSickSection(),
                );
              }
              if (state is! TodaysSickSectionStates) return const SizedBox.shrink();
              final rest = state.restaurants;
              return Skeletonizer(
                enabled: state is TodaysSickSectionLoading,
                child: RestHorzScrollVertCardListComponent(
                  title: L10n.tr().todayPicks,
                  items: rest,
                  onViewAllPressed: null,
                ),
              );
            },
          ),
          const _AddWidget(),
          const _PickToYou(),
        ],
      ),
    );
  }
}
