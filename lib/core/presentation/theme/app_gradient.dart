import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class Grad {
  /// pharmacy gradient
  final pharmacyLinearGrad = const LinearGradient(
    colors: [Co.greenish, Co.blueish],
    begin: Alignment(-0.5, 1),
    end: Alignment(0.7, -1),
    stops: [0.1, 1],
  );

  /// restaurant gradients
  final linearGradient = LinearGradient(
    colors: [Co.lightPurple, Co.darkPurple.withAlpha(201), Co.darkPurple.withAlpha(0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomCenter,
    stops: [0.07, 0.79, 1.0],
  );
  RadialGradient get radialGradient => const RadialGradient(
    colors: [Co.mauve, Co.darkMauve],
    center: Alignment.center,
    radius: 1,
  );
  LinearGradient get textGradient => const LinearGradient(
    colors: [Color(0xFF6F2BCB), Co.mauve, Color(0xFF0D0130)],
    end: Alignment.bottomRight,
    begin: Alignment.topLeft,
    stops: [0.0, 0.6, 1.0],
  );

  ///
  LinearGradient shadowGrad([bool isVertical = true]) => LinearGradient(
    colors: [Colors.black.withAlpha(0), Co.buttonGradient],
    begin: isVertical ? Alignment.topCenter : Alignment.centerRight,
    end: isVertical ? Alignment.bottomCenter : Alignment.centerLeft,
    stops: [0.0, 0.5],
  );
  final errorGradient = const LinearGradient(
    colors: [Colors.transparent, Co.red],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.0, 0.5],
  );
  final bgLinear = const LinearGradient(
    colors: [Color(0xFF402788), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.2, 0.8],
  );
  LinearGradient get bglightLinear => bgLinear.copyWith(
    colors: [Co.buttonGradient.withAlpha(80), Co.bg.withAlpha(0)],
    stops: const [0.0, 1],
  );

  final hoverGradient = const LinearGradient(
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
