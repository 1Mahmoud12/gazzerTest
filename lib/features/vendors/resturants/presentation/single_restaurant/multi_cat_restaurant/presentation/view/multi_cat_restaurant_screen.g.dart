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
      MultiCatRestaurantsRoute($extra: state.extra as SingleRestaurantLoaded);

  MultiCatRestaurantsRoute get _self => this as MultiCatRestaurantsRoute;

  @override
  String get location => GoRouteData.$location('/multi-cat-restaurant');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}
