// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_otp_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$verifyOTPScreenRoute];

RouteBase get $verifyOTPScreenRoute => GoRouteData.$route(
  path: '/verify-otp',

  factory: _$VerifyOTPScreenRoute._fromState,
);

mixin _$VerifyOTPScreenRoute on GoRouteData {
  static VerifyOTPScreenRoute _fromState(GoRouterState state) =>
      VerifyOTPScreenRoute(
        initPhone: state.uri.queryParameters['init-phone']!,
        data: state.uri.queryParameters['data']!,
        $extra: state.extra as (VerifyRepo, dynamic Function(BuildContext)),
      );

  VerifyOTPScreenRoute get _self => this as VerifyOTPScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/verify-otp',
    queryParams: {'init-phone': _self.initPhone, 'data': _self.data},
  );

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
