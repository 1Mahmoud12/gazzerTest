import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class MenuCategoriesHeaderWidget extends StatelessWidget {
  final String title;
  final List<Color> colors;

  const MenuCategoriesHeaderWidget({
    super.key,
    required this.title,
    required this.colors,
  });
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + (1.5 * kToolbarHeight);
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: height,
        width: constraints.maxWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            OverflowBox(
              alignment: Alignment.centerRight,
              maxHeight: height,
              minHeight: height,
              maxWidth: 780,
              minWidth: 780,
              child: Hero(
                tag: Tags.spickyShape,
                child: ClipPath(
                  clipper: AddShapeClipper(),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: Grad().bgLinear.copyWith(
                        colors: colors,
                        stops: const [0.0, 1],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            MainAppBar(title: title),
          ],
        ),
      ),
    );
  }
}
