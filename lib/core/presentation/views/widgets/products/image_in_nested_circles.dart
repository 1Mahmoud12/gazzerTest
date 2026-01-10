import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';

class ImageInNestedCircles extends StatelessWidget {
  const ImageInNestedCircles({
    super.key,
    required this.image,
    required this.imageRatio,
    this.text,
  });
  final String image;
  final int imageRatio;
  final Widget? text;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      clipBehavior: Clip.hardEdge,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: Grad().bglightLinear.copyWith(
            colors: [const Color(0xffCFC8DA), Co.bg],
          ),
          border: GradientBoxBorder(
            gradient: LinearGradient(
              colors: [Colors.black.withAlpha(0), Co.buttonGradient],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.5, 1],
            ),
            width: 2,
          ),
        ),
        child: AspectRatio(
          aspectRatio: 1,
          child: Column(
            children: [
              Expanded(
                flex: imageRatio,
                child: ClipOval(
                  clipBehavior: Clip.hardEdge,
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: GradientBoxBorder(gradient: Grad().shadowGrad()),
                    ),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CustomNetworkImage(
                        image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: text ?? const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
