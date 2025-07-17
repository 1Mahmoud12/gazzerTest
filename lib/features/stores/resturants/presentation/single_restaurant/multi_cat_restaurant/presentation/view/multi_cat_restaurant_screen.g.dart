// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_cat_restaurant_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$multiCatRestaurantsRoute];

RouteBase get $multiCatRestaurantsRoute => GoRouteData.$route(
  path: '/multi-cat-restaurant',

  factory: _$MultiCatRestaurantsRoute._fromState,
);

mixin _$MultiCatRestaurantsRoute on GoRouteData {
  static MultiCatRestaurantsRoute _fromState(GoRouterState state) =>
      MultiCatRestaurantsRoute(
        id: int.parse(state.uri.queryParameters['id']!)!,
      );

  MultiCatRestaurantsRoute get _self => this as MultiCatRestaurantsRoute;

  @override
  String get location => GoRouteData.$location(
    '/multi-cat-restaurant',
    queryParams: {'id': _self.id.toString()},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
