import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppNavigator().initContext = context;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Menu Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
