// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_password_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$createPasswordRoute];

RouteBase get $createPasswordRoute => GoRouteData.$route(
  path: '/create-password',

  factory: _$CreatePasswordRoute._fromState,
);

mixin _$CreatePasswordRoute on GoRouteData {
  static CreatePasswordRoute _fromState(GoRouterState state) =>
      CreatePasswordRoute($extra: state.extra as RegisterRequest);

  CreatePasswordRoute get _self => this as CreatePasswordRoute;

  @override
  String get location => GoRouteData.$location('/create-password');

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
