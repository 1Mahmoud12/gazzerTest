// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_related_restaurants_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$catRelatedRestaurantsRoute];

RouteBase get $catRelatedRestaurantsRoute => GoRouteData.$route(
  path: '/cat-related-restaurant',

  factory: _$CatRelatedRestaurantsRoute._fromState,
);

mixin _$CatRelatedRestaurantsRoute on GoRouteData {
  static CatRelatedRestaurantsRoute _fromState(GoRouterState state) => CatRelatedRestaurantsRoute(
    id: int.parse(state.uri.queryParameters['id']!)!,
  );

  CatRelatedRestaurantsRoute get _self => this as CatRelatedRestaurantsRoute;

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
