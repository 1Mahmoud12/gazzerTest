import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';

class StackedImagesWidget extends StatelessWidget {
  const StackedImagesWidget({super.key, required this.images});
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) return const SizedBox.shrink();
    const double radius = 10.0; // Radius for the CircleAvatar
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: (radius * 2) + (radius * min(images.length.toDouble(), 3)),
          height: radius * 2,
          child: Stack(
            children: List.generate(min(images.length, 4), (i) {
              return Positioned(
                left: i * radius,
                child: CircleAvatar(
                  radius: radius,
                  backgroundImage: NetworkImage(images[i]),
                  onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.image, size: 24),
                ),
              );
            }),
          ),
        ),
        if (images.length > 4) Text('+${images.length - 4} ${L10n.tr().items}', style: context.style14400.copyWith(fontWeight: TStyle.bold)),
      ],
    );
  }
}
