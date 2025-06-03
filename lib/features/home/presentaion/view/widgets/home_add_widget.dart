import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:lottie/lottie.dart';

class HomeAddWidget extends StatelessWidget {
  const HomeAddWidget({super.key, required this.color, required this.image, required this.text});
  final Color color;
  final String image;
  final Widget text;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print(constraints.maxWidth);
        return SizedBox(
          height: 170,
          width: constraints.maxWidth,
          child: Stack(
            children: [
              FractionallySizedBox(
                widthFactor: 1.1,
                child: SvgPicture.asset(
                  Assets.assetsSvgAddContainer,
                  width: constraints.maxWidth,
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
              Row(
                children: [
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: image.endsWith('svg')
                            ? SvgPicture.asset(image, height: 150, fit: BoxFit.contain)
                            : image.endsWith('json')
                            ? Lottie.asset(image, fit: BoxFit.contain, alignment: Alignment.bottomCenter)
                            : Image.asset(image, height: 150, fit: BoxFit.contain),
                      ),
                    ),

                  Expanded(flex: 3, child: text),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
