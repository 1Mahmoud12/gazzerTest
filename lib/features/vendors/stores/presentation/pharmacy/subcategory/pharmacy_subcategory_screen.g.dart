// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_subcategory_screen.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

extension $PharmacySubcategoryRouteExtension on PharmacySubcategoryRoute {
  static PharmacySubcategoryRoute _fromState(GoRouterState state) =>
      PharmacySubcategoryRoute(
        categoryId: int.parse(state.pathParameters['categoryId']!),
        categoryName: state.pathParameters['categoryName']!,
      );

  String get location => GoRouteData.$location(
    '/pharmacy-subcategory/${Uri.encodeComponent(categoryId.toString())}/${Uri.encodeComponent(categoryName)}',
  );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
