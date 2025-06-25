import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/features/orders/views/orders_screen.dart';

class OrdersNavigator extends StatelessWidget {
  const OrdersNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: AppNavigator().ordersKey,
      onGenerateInitialRoutes: (navigator, initialRoute) {
        AppNavigator().initContext = context;
        return Navigator.defaultGenerateInitialRoutes(navigator, initialRoute);
      },
      onDidRemovePage: (page) {},
      pages: [const MaterialPage(child: OrdersScreen())],
    );
  }
}
