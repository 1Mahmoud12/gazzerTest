// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'select_location_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$selectLocationRoute];

RouteBase get $selectLocationRoute => GoRouteData.$route(
  path: '/select-location',

  factory: _$SelectLocationRoute._fromState,
);

mixin _$SelectLocationRoute on GoRouteData {
  static SelectLocationRoute _fromState(GoRouterState state) =>
      SelectLocationRoute(
        state.extra
            as ({
              LatLng? initLocation,
              dynamic Function(BuildContext, LatLng) onSubmit,
            }),
      );

  SelectLocationRoute get _self => this as SelectLocationRoute;

  @override
  String get location => GoRouteData.$location('/select-location');

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
