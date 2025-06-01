import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class Grad {
  Grad._();
  static final linearGradient = LinearGradient(
    colors: [const Color(0xFF402788), const Color(0x99230064), const Color(0x00230064)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.07, 0.79, 1.0],
  );
  static final shadowGrad = LinearGradient(
    colors: [Colors.transparent, Co.burble],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.0, 0.5],
  );
  static final errorGradient = LinearGradient(
    colors: [Colors.transparent, Co.red],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.0, 0.5],
  );
  static final bgLinear = LinearGradient(
    colors: [const Color(0xFF402788), Colors.transparent],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: const [0.2, 0.8],
  );
  static final hoverGradient = LinearGradient(
    colors: [const Color(0x00402788), const Color(0xFF402788)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static RadialGradient get radialGradient =>
      RadialGradient(colors: [const Color(0xFF250266), const Color(0xFF010014)], center: Alignment.center, radius: 1);
}
