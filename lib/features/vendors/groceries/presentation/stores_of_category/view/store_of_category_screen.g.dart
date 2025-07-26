// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_of_category_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$storeOfCategoryRoute];

RouteBase get $storeOfCategoryRoute => GoRouteData.$route(
  path: '/stores-of-category',

  factory: _$StoreOfCategoryRoute._fromState,
);

mixin _$StoreOfCategoryRoute on GoRouteData {
  static StoresOfCategoryRoute _fromState(GoRouterState state) =>
      StoresOfCategoryRoute(
        vendorId: int.parse(state.uri.queryParameters['vendor-id']!)!,
      );

  StoresOfCategoryRoute get _self => this as StoresOfCategoryRoute;

  @override
  String get location => GoRouteData.$location(
    '/stores-of-category',
    queryParams: {'vendor-id': _self.vendorId.toString()},
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
