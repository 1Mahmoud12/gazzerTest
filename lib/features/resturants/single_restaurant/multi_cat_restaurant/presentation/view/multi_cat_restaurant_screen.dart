import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class MultiCatRestaurantsScreen extends StatelessWidget {
  const MultiCatRestaurantsScreen({super.key, required this.vendorId});
  final int vendorId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: MainAppBar());
  }
}
