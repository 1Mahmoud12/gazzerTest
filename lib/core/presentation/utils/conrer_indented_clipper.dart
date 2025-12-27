import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

//Add this CustomPaint widget to the Widget Tree

//Copy this CustomPainter code to the Bottom of the File
class ConrerIndentedClipper extends CustomClipper<Path> {
  final Size indent;
  final Corner corner;

  ConrerIndentedClipper({this.indent = const Size(40, 40), this.corner = Corner.bottomRight});

  @override
  Path getClip(Size size) {
    final double borderRadius = max(size.height, size.width) * 0.1;

    Path path_0 = Path();
    if (corner == Corner.topLeft) {
      path_0.moveTo(indent.width * 1.1, 0);
    } else {
      path_0.moveTo(size.width * 0.3333333, 0);
    }

    ///
    /// TOP RIGHT CORNER
    if (corner == Corner.topRight) {
      path_0.lineTo(size.width - (indent.width * 1.1), 0);
      path_0.arcToPoint(
        // corner start angle
        Offset(size.width - indent.width, indent.height * 0.1),
        radius: Radius.circular(borderRadius),
      );
      path_0.lineTo(size.width - indent.width, indent.height * 0.9);
      path_0.arcToPoint(
        // corner  angle
        Offset(size.width - (indent.width * 0.9), indent.height),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      );
      path_0.lineTo(size.width - (indent.width * 0.1), indent.height);
      path_0.arcToPoint(
        // corner end  angle
        Offset(size.width, indent.height * 1.1),
        radius: Radius.circular(borderRadius),
      );
    } else {
      path_0.lineTo(size.width * 0.9333333, 0);
      path_0.arcToPoint(
        // right top corner
        Offset(size.width, size.height * 0.08695652),
        radius: Radius.circular(borderRadius),
      );
    }

    ///
    /// BOTTOM RIGHT CORNER
    if (corner == Corner.bottomRight) {
      path_0.lineTo(size.width, size.height - (indent.height * 1.1));
      path_0.arcToPoint(
        // indent start corner
        Offset(size.width - (indent.width * 0.1), size.height - indent.height),
        radius: Radius.circular(borderRadius),
      );
      path_0.lineTo(size.width - (indent.width * 0.8), size.height - indent.height);
      path_0.arcToPoint(
        // indent corner
        Offset(size.width - indent.width, size.height - (indent.height * 0.8)),
        radius: Radius.circular(borderRadius),
        clockwise: false,
      );
      path_0.lineTo(size.width - indent.width, size.height - (indent.height * 0.2));
      path_0.arcToPoint(
        // indent end corner
        Offset(size.width - (indent.width * 1.2), size.height),
        radius: Radius.circular(borderRadius),
      );
    } else {
      path_0.lineTo(size.width, size.height * 0.9130435);
      path_0.arcToPoint(Offset(size.width * 0.9333333, size.height), radius: Radius.circular(borderRadius));
    }

    ///
    /// BOTTOM LEFT CORNER
    if (corner == Corner.bottomLeft) {
      path_0.lineTo(indent.width * 1.1, size.height);
      path_0.arcToPoint(Offset(indent.width, size.height - (indent.height * 0.1)), radius: Radius.circular(borderRadius));
      path_0.lineTo(indent.width, size.height - (indent.height * 0.9));
      path_0.arcToPoint(Offset(indent.width * 0.9, size.height - indent.height), radius: Radius.circular(borderRadius), clockwise: false);
      path_0.lineTo(indent.width * 0.1, size.height - indent.height);
      path_0.arcToPoint(Offset(0, size.height - (indent.height * 1.1)), radius: Radius.circular(borderRadius));
    } else {
      path_0.lineTo(size.width * 0.06666667, size.height);
      path_0.arcToPoint(Offset(0, size.height * 0.9130435), radius: Radius.circular(borderRadius));
    }

    ///
    ///

    ///
    /// LEFT TOP CORNER
    if (corner == Corner.topLeft) {
      path_0.lineTo(0, indent.height * 1.1);
      path_0.arcToPoint(Offset(indent.width * 0.1, indent.height), radius: Radius.circular(borderRadius));
      path_0.lineTo(indent.width * 0.9, indent.height);
      path_0.arcToPoint(Offset(indent.width, indent.height * 0.9), radius: Radius.circular(borderRadius), clockwise: false);
      path_0.lineTo(indent.width, indent.height * 0.1);
      path_0.arcToPoint(Offset(indent.width * 1.1, 0), radius: Radius.circular(borderRadius));
    } else {
      path_0.lineTo(0, size.height * 0.08695652);
      path_0.arcToPoint(Offset(size.width * 0.06666667, 0), radius: Radius.circular(borderRadius));
    }

    ///
    ///

    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
