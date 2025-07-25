// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_food_to_cart_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$addFoodToCartRoute];

RouteBase get $addFoodToCartRoute => GoRouteData.$route(
  path: '/add-to-cart',

  factory: _$AddFoodToCartRoute._fromState,
);

mixin _$AddFoodToCartRoute on GoRouteData {
  static AddFoodToCartRoute _fromState(GoRouterState state) =>
      AddFoodToCartRoute($extra: state.extra as GenericItemEntity);

  AddFoodToCartRoute get _self => this as AddFoodToCartRoute;

  @override
  String get location => GoRouteData.$location('/add-to-cart');

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
