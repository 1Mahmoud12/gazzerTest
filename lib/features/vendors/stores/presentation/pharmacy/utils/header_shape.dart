import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class PharmacyHeaderShape extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(55.1956, -86.4584);
    path_0.cubicTo(47.1037, -93.5061, 18.9983, -123.471, -35.968, -129.792);
    path_0.cubicTo(-102.673, -137.467, -124.882, -84.8173, -131.135, -69.7192);
    path_0.cubicTo(-154.129, -14.1983, -137.932, 35.6823, -111.791, 73.5525);
    path_0.cubicTo(-37.0017, 181.988, 104.594, 196.011, 160.345, 196.566);
    path_0.cubicTo(218.399, 197.139, 272.476, 176.855, 330.225, 174.658);
    path_0.cubicTo(366.919, 173.259, 404.327, 179.254, 439.58, 192.181);
    path_0.cubicTo(455.568, 198.055, 471.465, 205.438, 488.255, 206.785);
    path_0.cubicTo(523.434, 209.599, 553.323, 183.063, 557.641, 152.451);
    path_0.cubicTo(561.958, 121.839, 545.131, 89.66, 520.716, 65.3748);
    path_0.cubicTo(486.485, 31.3517, 445.395, -0.744454, 400.672, -20.8649);
    path_0.cubicTo(352.086, -42.6895, 294.486, -56.0583, 241.888, -56.1655);
    path_0.cubicTo(223.651, -56.207, 205.771, -53.5648, 187.632, -52.8468);
    path_0.cubicTo(149.907, -51.4011, 95.2114, -57.131, 63.0695, -80.1679);
    path_0.cubicTo(60.3361, -82.157, 57.7081, -84.2565, 55.1956, -86.4584);
    path_0.close();

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
