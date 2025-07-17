// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_edit_address_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$addEditAddressRoute];

RouteBase get $addEditAddressRoute => GoRouteData.$route(
  path: '/address',

  factory: _$AddEditAddressRoute._fromState,
);

mixin _$AddEditAddressRoute on GoRouteData {
  static AddEditAddressRoute _fromState(GoRouterState state) =>
      AddEditAddressRoute($extra: state.extra as AddressEntity?);

  AddEditAddressRoute get _self => this as AddEditAddressRoute;

  @override
  String get location => GoRouteData.$location('/address');

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
