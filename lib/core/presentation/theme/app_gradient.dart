import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class Grad {
  Grad._();
  static final linearGradient = const LinearGradient(
    colors: [Color(0xFF933EFF), Color(0xAA230064), Color(0x00230064)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.07, 0.79, 1.0],
  );
  static RadialGradient get radialGradient =>
      const RadialGradient(colors: [Color(0xFF250266), Color(0xFF010014)], center: Alignment.center, radius: 0.7);

  ///
  static shadowGrad([bool isVertical = true]) => LinearGradient(
    colors: [Colors.transparent, Co.primary],
    begin: isVertical ? Alignment.topCenter : Alignment.centerRight,
    end: isVertical ? Alignment.bottomCenter : Alignment.centerLeft,
    stops: [0.0, 0.5],
  );
  static final errorGradient = const LinearGradient(
    colors: [Colors.transparent, Co.red],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5],
  );
  static final bgLinear = const LinearGradient(
    colors: [Color(0xFF402788), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.2, 0.8],
  );
  static final hoverGradient = const LinearGradient(
    colors: [Color(0x00402788), Color(0xFF402788)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

extension LinearGradientExt on LinearGradient {
  LinearGradient copyWith({
    List<Color>? colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<double>? stops,
  }) {
    return LinearGradient(
      colors: colors ?? this.colors,
      begin: begin ?? this.begin,
      end: end ?? this.end,
      stops: stops ?? this.stops,
    );
  }
}
