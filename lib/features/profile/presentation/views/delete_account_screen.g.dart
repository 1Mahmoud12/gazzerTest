// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_account_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$deleteAccountRoute];

RouteBase get $deleteAccountRoute => GoRouteData.$route(
  path: '/delete-account',

  factory: _$DeleteAccountRoute._fromState,
);

mixin _$DeleteAccountRoute on GoRouteData {
  static DeleteAccountRoute _fromState(GoRouterState state) =>
      DeleteAccountRoute($extra: state.extra as ProfileCubit);

  DeleteAccountRoute get _self => this as DeleteAccountRoute;

  @override
  String get location => GoRouteData.$location('/delete-account');

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
