import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';

class AppRatingWidget extends StatelessWidget {
  final String initialRating;
  final double itemSize;
  final bool ignoreGesture;
  final Function(double)? onRate;
  const AppRatingWidget(this.initialRating, {this.itemSize = 15, this.ignoreGesture = true, super.key, this.onRate});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(Assets.starRateIc, width: 20, height: 20),
        const HorizontalSpacing(4),
        Text('${double.tryParse(initialRating) ?? 0.0}', style: context.style16400),
      ],
    );
  }
}
