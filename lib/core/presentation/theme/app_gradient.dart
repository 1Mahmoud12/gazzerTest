import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class Grad {
  Grad._();
  static final linearGradient = LinearGradient(
    colors: [Co.lightPurple, Co.darkPurple.withAlpha(201), Co.darkPurple.withAlpha(0)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [0.07, 0.79, 1.0],
  );
  static final radialGradient = const RadialGradient(
    colors: [Co.mauve, Co.darkMauve],
    center: Alignment.center,
    radius: 0.7,
  );
  static final textGradient = const LinearGradient(
    colors: [Co.purple, Co.mauve],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.0, 0.8],
  );

  ///
  static LinearGradient shadowGrad([bool isVertical = true]) => LinearGradient(
    colors: [Colors.black.withAlpha(0), Co.buttonGradient],
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
  static final bglightLinear = bgLinear.copyWith(
    colors: [Co.buttonGradient.withAlpha(80), Co.bg.withAlpha(0)],
    stops: const [0.0, 1],
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

extension RadialGradientExtension on RadialGradient {
  RadialGradient copyWith({List<Color>? colors, AlignmentGeometry? center, double? radius, List<double>? stops}) {
    return RadialGradient(
      colors: colors ?? this.colors,
      center: center ?? this.center,
      radius: radius ?? this.radius,
      stops: stops ?? this.stops,
    );
  }
}

extension GradientExtension on Gradient {
  Gradient copyWith({
    List<Color>? colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    List<double>? stops,
    double? radius,
  }) {
    if (this is LinearGradient) {
      return (this as LinearGradient).copyWith(colors: colors, begin: begin, end: end, stops: stops);
    } else if (this is RadialGradient) {
      return (this as RadialGradient).copyWith(colors: colors, center: begin, radius: radius, stops: stops);
    }
    return this;
  }
}
