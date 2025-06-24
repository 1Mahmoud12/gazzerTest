import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/utils/add_shape_painter.dart';
import 'package:lottie/lottie.dart';

class SpikyShapeWidget extends StatelessWidget {
  const SpikyShapeWidget({
    super.key,
    required this.color,
    this.image,
    required this.rtChild,
    this.ltChild,
    this.heroTag,
  }) : assert(image != null || ltChild != null, 'Image or ltChild must not be null');
  final Color color;
  final String? image;
  final Widget rtChild;
  final Widget? ltChild;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final fraction = 1.08;
    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor: fraction,
          child: Hero(
            tag: heroTag ?? 'spiky_shape_widget',
            child: CustomPaint(
              painter: AddShapePainter(color: color),
              child: SizedBox(
                height: 170,
                width: constraints.maxWidth,
                child: FractionallySizedBox(
                  widthFactor: 1 / fraction,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        ltChild ??
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: image!.endsWith('svg')
                                    ? SvgPicture.asset(image!, height: 150, fit: BoxFit.contain)
                                    : image!.endsWith('json')
                                    ? Lottie.asset(image!, fit: BoxFit.contain, alignment: Alignment.bottomCenter)
                                    : Image.asset(image!, height: 150, fit: BoxFit.contain),
                              ),
                            ),

                        Expanded(flex: 3, child: rtChild),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class HomeDoubleAddWidget extends StatelessWidget {
  const HomeDoubleAddWidget({
    super.key,
    required this.fgColor,
    required this.bgColor,
    this.image,
    required this.rtChild,
    this.ltChild,
    this.rtFlex,
  }) : assert(image != null || ltChild != null, 'Either image or lfChild must be provided');

  final Color fgColor;
  final Color bgColor;
  final String? image;
  final Widget rtChild;
  final Widget? ltChild;
  final int? rtFlex;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor: 1.1,
          child: SizedBox(
            height: 170,
            width: constraints.maxWidth,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomPaint(
                    painter: AddShapePainter(color: bgColor),
                    child: SizedBox(height: 150, width: constraints.maxWidth),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomPaint(
                    painter: AddShapePainter(color: fgColor),
                    child: SizedBox(height: 150, width: constraints.maxWidth),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: constraints.maxWidth,
                  child: Row(
                    children: [
                      ltChild ??
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: image!.endsWith('svg')
                                  ? SvgPicture.asset(image!, height: 150, fit: BoxFit.contain)
                                  : image!.endsWith('json')
                                  ? Lottie.asset(image!, fit: BoxFit.contain, alignment: Alignment.bottomCenter)
                                  : Image.asset(image!, height: 150, fit: BoxFit.contain),
                            ),
                          ),

                      Expanded(flex: rtFlex ?? 3, child: rtChild),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
