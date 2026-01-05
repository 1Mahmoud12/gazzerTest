// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_menu_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

mixin _$PharmacyMenuRoute on GoRouteData {
  static PharmacyMenuRoute _fromState(GoRouterState state) => PharmacyMenuRoute(id: int.parse(state.uri.queryParameters['id']!)!);

  PharmacyMenuRoute get _self => this as PharmacyMenuRoute;

  @override
  String get location => GoRouteData.$location('/pharmacy-menu', queryParams: {'id': _self.id.toString()});

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
