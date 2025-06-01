import 'package:flutter/material.dart';

class Grad {
  Grad._();
  static final linearGradient = LinearGradient(
    colors: [const Color(0xFF933EFF), const Color(0x99230064), const Color(0x00230064)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.07, 0.79, 1.0],
  );
  static final hoverGradient = LinearGradient(
    colors: [const Color(0x00402788), const Color(0xFF402788)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static final radialGradient = RadialGradient(
    colors: [const Color(0xFF250266), const Color(0xFF010014)],
    center: Alignment.center,
    radius: 0.7,
  );
}
