import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

class StackedItemWidget extends StatelessWidget {
  const StackedItemWidget({super.key, required this.items});
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    final double radius = 10.0; // Radius for the CircleAvatar
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (radius * 2) + (radius * min(items.length.toDouble(), 3)),
          height: (radius*2),
          child: Stack(
            children: List.generate(min(items.length, 4), (i) {
              return Positioned(
                left: i * radius,
                child: CircleAvatar(radius: radius, backgroundImage: AssetImage(items[i])),
              );
            }),
          ),
        ),
        if (items.length > 4) Text("+${items.length - 4} items", style: TStyle.blackBold(12)),
      ],
    );
  }
}
