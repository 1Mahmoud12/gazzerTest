import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

//Copy this CustomPainter code to the Bottom of the File
class CornerIndendetShape extends CustomPainter {
  final Size indent;
  final Corner corner;
  final double strokeWidth;

  final (Color? shadowColor, double? shadowBlurRadius)? shadow;
  final (Color begin, Color end)? border;

  CornerIndendetShape({
    this.indent = const Size(40, 40),
    this.corner = Corner.bottomRight,
    this.shadow,
    this.border = const (Colors.transparent, Colors.transparent),
    this.strokeWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
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
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
      path_0.lineTo(size.width - indent.width, indent.height * 0.9);
      path_0.arcToPoint(
        // corner  angle
        Offset(size.width - (indent.width * 0.9), indent.height),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      );
      path_0.lineTo(size.width - (indent.width * 0.1), indent.height);
      path_0.arcToPoint(
        // corner end  angle
        Offset(size.width, indent.height * 1.1),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    } else {
      path_0.lineTo(size.width * 0.9333333, 0);
      path_0.arcToPoint(
        // right top corner
        Offset(size.width, size.height * 0.08695652),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
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
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
      path_0.lineTo(size.width - (indent.width * 0.8), size.height - indent.height);
      path_0.arcToPoint(
        // indent corner
        Offset(size.width - indent.width, size.height - (indent.height * 0.8)),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      );
      path_0.lineTo(size.width - indent.width, size.height - (indent.height * 0.2));
      path_0.arcToPoint(
        // indent end corner
        Offset(size.width - (indent.width * 1.2), size.height),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    } else {
      path_0.lineTo(size.width, size.height * 0.9130435);
      path_0.arcToPoint(
        Offset(size.width * 0.9333333, size.height),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    }

    ///
    /// BOTTOM LEFT CORNER
    if (corner == Corner.bottomLeft) {
      path_0.lineTo(indent.width * 1.1, size.height);
      path_0.arcToPoint(
        Offset(indent.width, size.height - (indent.height * 0.1)),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
      path_0.lineTo(indent.width, size.height - (indent.height * 0.9));
      path_0.arcToPoint(
        Offset(indent.width * 0.9, size.height - indent.height),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      );
      path_0.lineTo(indent.width * 0.1, size.height - indent.height);
      path_0.arcToPoint(
        Offset(0, size.height - (indent.height * 1.1)),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    } else {
      path_0.lineTo(size.width * 0.06666667, size.height);
      path_0.arcToPoint(
        Offset(0, size.height * 0.9130435),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    }

    ///
    ///

    ///
    /// LEFT TOP CORNER
    if (corner == Corner.topLeft) {
      path_0.lineTo(0, indent.height * 1.1);
      path_0.arcToPoint(
        Offset(indent.width * 0.1, indent.height),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
      path_0.lineTo(indent.width * 0.9, indent.height);
      path_0.arcToPoint(
        Offset(indent.width, indent.height * 0.9),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: false,
      );
      path_0.lineTo(indent.width, indent.height * 0.1);
      path_0.arcToPoint(
        Offset(indent.width * 1.1, 0),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    } else {
      path_0.lineTo(0, size.height * 0.08695652);
      path_0.arcToPoint(
        Offset(size.width * 0.06666667, 0),
        radius: Radius.circular(borderRadius),
        rotation: 0,
        largeArc: false,
        clockwise: true,
      );
    }

    ///
    ///

    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    // Draw shadow
    if (shadow == null) {
      if (border != null) {
        paint0Stroke.shader = ui.Gradient.linear(
          Offset(size.width, 0),
          Offset(size.width, size.height),
          [border!.$1, border!.$2],
          [0.1, 1],
        );
      }
    }

    canvas.drawPath(path_0, paint0Stroke);
    if (shadow != null) {
      canvas.drawShadow(
        path_0,
        shadow?.$1 ?? Colors.black26,
        shadow?.$2 ?? 2,
        false,
      );
    }

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.transparent;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
