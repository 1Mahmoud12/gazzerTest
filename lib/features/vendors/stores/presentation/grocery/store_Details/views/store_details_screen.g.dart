// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_details_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$storeDetailsRoute];

RouteBase get $storeDetailsRoute => GoRouteData.$route(
  path: '/store-details',

  factory: _$StoreDetailsRoute._fromState,
);

mixin _$StoreDetailsRoute on GoRouteData {
  static StoreDetailsRoute _fromState(GoRouterState state) => StoreDetailsRoute(
    storeId: int.parse(state.uri.queryParameters['store-id']!)!,
  );

  StoreDetailsRoute get _self => this as StoreDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/store-details',
    queryParams: {'store-id': _self.storeId.toString()},
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
