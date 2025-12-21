// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_store_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$pharmacyStoreScreenRoute];

RouteBase get $pharmacyStoreScreenRoute => GoRouteData.$route(path: '/pharmacy-store', factory: _$PharmacyStoreScreenRoute._fromState);

mixin _$PharmacyStoreScreenRoute on GoRouteData {
  static PharmacyStoreScreenRoute _fromState(GoRouterState state) => PharmacyStoreScreenRoute(id: int.parse(state.uri.queryParameters['id']!));

  PharmacyStoreScreenRoute get _self => this as PharmacyStoreScreenRoute;

  @override
  String get location => GoRouteData.$location('/pharmacy-store', queryParams: {'id': _self.id.toString()});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}




