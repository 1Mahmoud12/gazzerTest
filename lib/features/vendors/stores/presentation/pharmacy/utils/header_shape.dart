import 'package:flutter/material.dart';

/// Custom clipper for pharmacy header with wave shape
/// The original design height is approximately 200 pixels
class PharmacyHeaderShape extends CustomClipper<Path> {
  const PharmacyHeaderShape({this.height = 200.0});

  final double height;

  @override
  Path getClip(Size size) {
    final Path path_0 = Path();
    // Calculate scale factor based on desired height
    // Original design height is approximately 200 pixels
    const double originalHeight = 200.0;
    final double scale = height / originalHeight;
    path_0.moveTo(55.1956 * scale, -86.4584 * scale);
    path_0.cubicTo(
      47.1037 * scale,
      -93.5061 * scale,
      18.9983 * scale,
      -123.471 * scale,
      -35.968 * scale,
      -129.792 * scale,
    );
    path_0.cubicTo(
      -102.673 * scale,
      -137.467 * scale,
      -124.882 * scale,
      -84.8173 * scale,
      -131.135 * scale,
      -69.7192 * scale,
    );
    path_0.cubicTo(
      -154.129 * scale,
      -14.1983 * scale,
      -137.932 * scale,
      35.6823 * scale,
      -111.791 * scale,
      73.5525 * scale,
    );
    path_0.cubicTo(
      -37.0017 * scale,
      181.988 * scale,
      104.594 * scale,
      196.011 * scale,
      160.345 * scale,
      196.566 * scale,
    );
    path_0.cubicTo(
      218.399 * scale,
      197.139 * scale,
      272.476 * scale,
      176.855 * scale,
      330.225 * scale,
      174.658 * scale,
    );
    path_0.cubicTo(
      366.919 * scale,
      173.259 * scale,
      404.327 * scale,
      179.254 * scale,
      439.58 * scale,
      192.181 * scale,
    );
    path_0.cubicTo(
      455.568 * scale,
      198.055 * scale,
      471.465 * scale,
      205.438 * scale,
      488.255 * scale,
      206.785 * scale,
    );
    path_0.cubicTo(
      523.434 * scale,
      209.599 * scale,
      553.323 * scale,
      183.063 * scale,
      557.641 * scale,
      152.451 * scale,
    );
    path_0.cubicTo(
      561.958 * scale,
      121.839 * scale,
      545.131 * scale,
      89.66 * scale,
      520.716 * scale,
      65.3748 * scale,
    );
    path_0.cubicTo(
      486.485 * scale,
      31.3517 * scale,
      445.395 * scale,
      -0.744454 * scale,
      400.672 * scale,
      -20.8649 * scale,
    );
    path_0.cubicTo(
      352.086 * scale,
      -42.6895 * scale,
      294.486 * scale,
      -56.0583 * scale,
      241.888 * scale,
      -56.1655 * scale,
    );
    path_0.cubicTo(
      223.651 * scale,
      -56.207 * scale,
      205.771 * scale,
      -53.5648 * scale,
      187.632 * scale,
      -52.8468 * scale,
    );
    path_0.cubicTo(
      149.907 * scale,
      -51.4011 * scale,
      95.2114 * scale,
      -57.131 * scale,
      63.0695 * scale,
      -80.1679 * scale,
    );
    path_0.cubicTo(
      60.3361 * scale,
      -82.157 * scale,
      57.7081 * scale,
      -84.2565 * scale,
      55.1956 * scale,
      -86.4584 * scale,
    );
    path_0.close();

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant PharmacyHeaderShape oldClipper) {
    return oldClipper.height != height;
  }
}
