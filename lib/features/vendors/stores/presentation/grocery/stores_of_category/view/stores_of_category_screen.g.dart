// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stores_of_category_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$storesOfCategoryRoute];

RouteBase get $storesOfCategoryRoute => GoRouteData.$route(
  path: '/stores-of-category',

  factory: _$StoresOfCategoryRoute._fromState,
);

mixin _$StoresOfCategoryRoute on GoRouteData {
  static StoresOfCategoryRoute _fromState(GoRouterState state) => StoresOfCategoryRoute(
    mainCatId: int.parse(state.uri.queryParameters['main-cat-id']!),
    subCatId: int.parse(state.uri.queryParameters['sub-cat-id']!),
  );

  StoresOfCategoryRoute get _self => this as StoresOfCategoryRoute;

  @override
  String get location => GoRouteData.$location(
    '/stores-of-category',
    queryParams: {
      'main-cat-id': _self.mainCatId.toString(),
      'sub-cat-id': _self.subCatId.toString(),
    },
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
