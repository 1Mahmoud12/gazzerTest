// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurants_of_category_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$restaurantsOfCategoryRoute];

RouteBase get $restaurantsOfCategoryRoute => GoRouteData.$route(
  path: '/cat-related-restaurant',

  factory: _$RestaurantsOfCategoryRoute._fromState,
);

mixin _$RestaurantsOfCategoryRoute on GoRouteData {
  static RestaurantsOfCategoryRoute _fromState(GoRouterState state) => RestaurantsOfCategoryRoute(
    id: int.parse(state.uri.queryParameters['id']!),
  );

  RestaurantsOfCategoryRoute get _self => this as RestaurantsOfCategoryRoute;

  @override
  String get location => GoRouteData.$location(
    '/cat-related-restaurant',
    queryParams: {'id': _self.id.toString()},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
