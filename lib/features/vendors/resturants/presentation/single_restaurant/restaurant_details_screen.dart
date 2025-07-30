import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/classic_app_bar.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_cat_restaurant_details.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'restaurant_details_screen.g.dart';

@TypedGoRoute<RestaurantDetilsRoute>(path: RestaurantDetilsScreen.route)
@immutable
class RestaurantDetilsRoute extends GoRouteData with _$RestaurantDetilsRoute {
  const RestaurantDetilsRoute({required this.id});
  final int id;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<SingleRestaurantCubit>(param1: id),
      child: RestaurantDetilsScreen(id: id),
    );
  }
}

class RestaurantDetilsScreen extends StatelessWidget {
  static const route = '/restaurant-details';
  const RestaurantDetilsScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleRestaurantCubit, SingleRestaurantStates>(
      listener: (context, state) {
        if (state is SingleRestaurantLoaded) {
          if (state.isSingle && state.categoriesWithPlates.isNotEmpty && state.categoriesWithPlates.first.$2.isNotEmpty) {
            SingleCatRestaurantRoute($extra: state).pushReplacement(context);
          } else {
            MultiCatRestaurantsRoute($extra: state).pushReplacement(context);
          }
        }
      },
      builder: (context, state) {
        if (state is SingleRestaurantError ||
            (state is SingleRestaurantLoaded && (state.categoriesWithPlates.isEmpty || state.categoriesWithPlates.first.$2.isEmpty))) {
          return Scaffold(
            appBar: const ClassicAppBar(),
            body: FailureWidget(
              message: L10n.tr().couldnotLoadDataPleaseTryyAgain,
              onRetry: () => context.read<SingleRestaurantCubit>().loadSingleRestaurantData(),
            ),
          );
        } else {
          return Skeletonizer(
            child: SingleCatRestaurantScreen(
              hasParentProvider: false,
              state: SingleRestaurantLoaded(
                banners: [],
                restaurant: Fakers.restaurant,
                toprated: [],
                categoriesWithPlates: [(Fakers.categoryOfPlate, Fakers.plates)],
              ),
            ),
          );
        }
      },
    );
  }
}
