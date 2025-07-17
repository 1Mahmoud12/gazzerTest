// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'congrats_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$congratsScreenRoute];

RouteBase get $congratsScreenRoute => GoRouteData.$route(
  path: '/congrats',

  factory: _$CongratsScreenRoute._fromState,
);

mixin _$CongratsScreenRoute on GoRouteData {
  static CongratsScreenRoute _fromState(GoRouterState state) =>
      CongratsScreenRoute(
        navigateToRoute: state.uri.queryParameters['navigate-to-route']!,
      );

  CongratsScreenRoute get _self => this as CongratsScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/congrats',
    queryParams: {'navigate-to-route': _self.navigateToRoute},
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
