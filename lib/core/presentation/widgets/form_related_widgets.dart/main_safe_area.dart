import 'package:flutter/material.dart';

class MainSafeArea extends StatelessWidget {
  const MainSafeArea({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: child);
  }
}
