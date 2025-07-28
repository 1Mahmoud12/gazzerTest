// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_details_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$restaurantDetilsRoute];

RouteBase get $restaurantDetilsRoute => GoRouteData.$route(
  path: '/restaurant-details',

  factory: _$RestaurantDetilsRoute._fromState,
);

mixin _$RestaurantDetilsRoute on GoRouteData {
  static RestaurantDetilsRoute _fromState(GoRouterState state) =>
      RestaurantDetilsRoute(id: int.parse(state.uri.queryParameters['id']!)!);

  RestaurantDetilsRoute get _self => this as RestaurantDetilsRoute;

  @override
  String get location => GoRouteData.$location(
    '/restaurant-details',
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
