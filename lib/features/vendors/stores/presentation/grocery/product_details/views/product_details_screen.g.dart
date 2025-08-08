// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$productDetailsRoute];

RouteBase get $productDetailsRoute => GoRouteData.$route(
  path: '/product-details',

  factory: _$ProductDetailsRoute._fromState,
);

mixin _$ProductDetailsRoute on GoRouteData {
  static ProductDetailsRoute _fromState(GoRouterState state) =>
      ProductDetailsRoute(
        productId: int.parse(state.uri.queryParameters['product-id']!)!,
        $extra: state.extra as CartItemEntity?,
      );

  ProductDetailsRoute get _self => this as ProductDetailsRoute;

  @override
  String get location => GoRouteData.$location(
    '/product-details',
    queryParams: {'product-id': _self.productId.toString()},
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
