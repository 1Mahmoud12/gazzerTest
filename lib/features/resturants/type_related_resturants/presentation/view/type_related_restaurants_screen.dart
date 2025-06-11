import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/widgets/main_app_bar.dart';
import 'package:gazzer/features/resturants/type_related_resturants/presentation/view/widgets/type_related_restaurants_header.dart';

class TypeRelatedRestaurantsScreen extends StatelessWidget {
  const TypeRelatedRestaurantsScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView(padding: EdgeInsets.zero, children: [const TypeRelatedRestaurantsHeader()]),
    );
  }
}
