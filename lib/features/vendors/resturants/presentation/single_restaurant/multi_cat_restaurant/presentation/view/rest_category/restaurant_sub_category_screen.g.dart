// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_sub_category_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$restaurantCategoryRoute];

RouteBase get $restaurantCategoryRoute => GoRouteData.$route(
  path: '/restaurant-category',

  factory: _$RestaurantCategoryRoute._fromState,
);

mixin _$RestaurantCategoryRoute on GoRouteData {
  static RestaurantCategoryRoute _fromState(GoRouterState state) =>
      RestaurantCategoryRoute(
        subCatId: int.parse(state.uri.queryParameters['sub-cat-id']!)!,
        subcatName: state.uri.queryParameters['subcat-name']!,
        $extra: state.extra as RestaurantEntity,
      );

  RestaurantCategoryRoute get _self => this as RestaurantCategoryRoute;

  @override
  String get location => GoRouteData.$location(
    '/restaurant-category',
    queryParams: {
      'sub-cat-id': _self.subCatId.toString(),
      'subcat-name': _self.subcatName,
    },
  );

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
