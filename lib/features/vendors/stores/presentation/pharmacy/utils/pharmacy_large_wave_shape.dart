import 'package:flutter/material.dart';

/// Custom clipper for pharmacy header with large wave shape
/// Designed specifically for height 350 pixels
class PharmacyLargeWaveShape extends CustomClipper<Path> {
  const PharmacyLargeWaveShape({this.height = 350.0});

  final double height;

  @override
  Path getClip(Size size) {
    Path path = Path();

    // Start from top-left corner
    path.moveTo(0, 0);

    // Line across the top
    path.lineTo(size.width, 0);

    // Line down the right side to where the wave starts
    // For 400 height, wave starts around 320-330 pixels down
    path.lineTo(size.width, height * 0.82);

    // Create smooth upward-curving wave using quadratic bezier
    // Control point in the middle pushes the curve down (creates upward bulge)
    path.quadraticBezierTo(
      size.width / 2, // Control point X (center)
      height * 0.95, // Control point Y (pushes curve down to create bulge)
      0, // End point X (left edge)
      height * 0.82, // End point Y (same as start)
    );

    // Line up the left side back to start
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant PharmacyLargeWaveShape oldClipper) {
    return oldClipper.height != height;
  }
}
