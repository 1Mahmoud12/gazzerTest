// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_cat_restaurant_details.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$singleCatRestaurantRoute];

RouteBase get $singleCatRestaurantRoute => GoRouteData.$route(
  path: '/single-cat-restaurant',

  factory: _$SingleCatRestaurantRoute._fromState,
);

mixin _$SingleCatRestaurantRoute on GoRouteData {
  static SingleCatRestaurantRoute _fromState(GoRouterState state) =>
      SingleCatRestaurantRoute($extra: state.extra as SingleRestaurantStates);

  SingleCatRestaurantRoute get _self => this as SingleCatRestaurantRoute;

  @override
  String get location => GoRouteData.$location('/single-cat-restaurant');

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
