import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

//Copy this CustomPainter code to the Bottom of the File
class ProductShapePaint extends CustomPainter {
  final Color begin;
  final Color end;

  ProductShapePaint({this.begin = Colors.black12, this.end = Co.buttonGradient});

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8821893, size.height * 0.009693466);
    path_0.cubicTo(
      size.width * 0.9402959,
      size.height * -0.004850187,
      size.width * 0.9970414,
      size.height * 0.03725688,
      size.width * 0.9970414,
      size.height * 0.09491534,
    );
    path_0.lineTo(size.width * 0.9970414, size.height * 0.9090909);
    path_0.cubicTo(
      size.width * 0.9970414,
      size.height * 0.9577273,
      size.width * 0.9559763,
      size.height * 0.9971591,
      size.width * 0.9053254,
      size.height * 0.9971591,
    );
    path_0.lineTo(size.width * 0.09467456, size.height * 0.9971591);
    path_0.cubicTo(
      size.width * 0.04402124,
      size.height * 0.9971591,
      size.width * 0.002958580,
      size.height * 0.9577273,
      size.width * 0.002958580,
      size.height * 0.9090909,
    );
    path_0.lineTo(size.width * 0.002958580, size.height * 0.2978239);
    path_0.cubicTo(
      size.width * 0.002958580,
      size.height * 0.2589943,
      size.width * 0.02941154,
      size.height * 0.2249080,
      size.width * 0.06778757,
      size.height * 0.2136233,
    );
    path_0.lineTo(size.width * 0.07153728, size.height * 0.2126023);
    path_0.lineTo(size.width * 0.8821893, size.height * 0.009693466);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    paint0Stroke.shader = ui.Gradient.linear(
      Offset(0, size.height * 0.4),
      Offset(size.width * 0.3, size.height),
      [begin, end],
      [0, 0.5],
    );
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = Colors.transparent;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
