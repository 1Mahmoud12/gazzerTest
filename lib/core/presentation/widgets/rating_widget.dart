import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class RatingWidget extends StatelessWidget {
  final String initialRating;
  final double itemSize;
  final bool ignoreGesture;
  final Function(double)? onRate;
  const RatingWidget(this.initialRating, {this.itemSize = 15, this.ignoreGesture = true, super.key, this.onRate});

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: double.tryParse(initialRating) ?? 0.0,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: itemSize,
      ignoreGestures: ignoreGesture,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Co.secondary,
      ),
      unratedColor: Co.grey,
      onRatingUpdate: (rating) {
        if (onRate != null) onRate!(rating);
      },
    );
  }
}
