import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/features/home/presentaion/utils/add_shape_clipper.dart';

class TypeRelatedRestaurantsHeader extends StatelessWidget {
  const TypeRelatedRestaurantsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 50;
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: height,
        width: constraints.maxWidth,
        child: FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: 1,
          widthFactor: 2,
          child: ClipPath(
            clipper: AddShapeClipper(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: Grad.bgLinear.copyWith(
                  colors: [Co.buttonGradient.withAlpha(200), Co.bg.withAlpha(0)],
                  stops: const [0.0, 1],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: height * 0.25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text("burger restaurants", style: TStyle.blackBold(24))],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
