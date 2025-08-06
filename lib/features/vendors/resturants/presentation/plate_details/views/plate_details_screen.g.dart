// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plate_details_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$plateDetailsRoute];

RouteBase get $plateDetailsRoute => GoRouteData.$route(
  path: '/single-plate',

  factory: _$PlateDetailsRoute._fromState,
);

mixin _$PlateDetailsRoute on GoRouteData {
  static PlateDetailsRoute _fromState(GoRouterState state) => PlateDetailsRoute(
    id: int.parse(state.uri.queryParameters['id']!)!,
    $extra: state.extra as CartItemEntity?,
  );

  PlateDetailsRoute get _self => this as PlateDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/single-plate',
    queryParams: {'id': _self.id.toString()},
  );

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) => context.replace(location, extra: _self.$extra);
}
