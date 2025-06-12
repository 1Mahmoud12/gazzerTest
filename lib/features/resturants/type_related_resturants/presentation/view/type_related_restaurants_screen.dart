import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/infinite_scrolling.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/helper_widgets.dart' show MainAppBar, VerticalSpacing;
import 'package:gazzer/features/home/presentaion/utils/add_shape_clipper.dart';

/// screen widgets

part './widgets/infinet_carousal.dart';
part './widgets/today_picks_widget.dart';
part './widgets/type_related_restaurants_header.dart';

class TypeRelatedRestaurantsScreen extends StatelessWidget {
  const TypeRelatedRestaurantsScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final items = [const _TypeRelatedRestaurantsHeader(), const _InfinetAnimatingCarousal()];
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => index == 0 ? const SizedBox.shrink() : const VerticalSpacing(16),
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
