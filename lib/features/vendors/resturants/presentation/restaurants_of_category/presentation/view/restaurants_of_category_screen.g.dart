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
  static RestaurantsOfCategoryRoute _fromState(GoRouterState state) =>
      RestaurantsOfCategoryRoute($extra: state.extra as CategoryOfPlateEntity);

  RestaurantsOfCategoryRoute get _self => this as RestaurantsOfCategoryRoute;

  @override
  String get location => GoRouteData.$location('/cat-related-restaurant');

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
