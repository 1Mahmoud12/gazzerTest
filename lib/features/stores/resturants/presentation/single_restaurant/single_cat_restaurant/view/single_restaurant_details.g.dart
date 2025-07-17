// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_restaurant_details.dart';

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
      SingleCatRestaurantRoute(
        id: int.parse(state.uri.queryParameters['id']!)!,
      );

  SingleCatRestaurantRoute get _self => this as SingleCatRestaurantRoute;

  @override
  String get location => GoRouteData.$location(
    '/single-cat-restaurant',
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
