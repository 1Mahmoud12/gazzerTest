// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$loadingScreenRoute];

RouteBase get $loadingScreenRoute => GoRouteData.$route(
  path: '/loading',

  factory: _$LoadingScreenRoute._fromState,
);

mixin _$LoadingScreenRoute on GoRouteData {
  static LoadingScreenRoute _fromState(GoRouterState state) =>
      LoadingScreenRoute(
        navigateToRoute: state.uri.queryParameters['navigate-to-route']!,
      );

  LoadingScreenRoute get _self => this as LoadingScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/loading',
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
