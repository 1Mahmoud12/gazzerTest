// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_menu_switcher.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$storeMenuSwitcherRoute];

RouteBase get $storeMenuSwitcherRoute => GoRouteData.$route(
  path: '/store-menu-switcher',

  factory: _$StoreMenuSwitcherRoute._fromState,
);

mixin _$StoreMenuSwitcherRoute on GoRouteData {
  static StoreMenuSwitcherRoute _fromState(GoRouterState state) =>
      StoreMenuSwitcherRoute(id: int.parse(state.uri.queryParameters['id']!)!);

  StoreMenuSwitcherRoute get _self => this as StoreMenuSwitcherRoute;

  @override
  String get location => GoRouteData.$location(
    '/store-menu-switcher',
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
