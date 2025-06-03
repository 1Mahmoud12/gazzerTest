import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: GradientBoxBorder(gradient: Grad.shadowGrad(false)),
          borderRadius: BorderRadius.circular(constraints.maxWidth),
        ),
        height: constraints.minHeight,
        width: constraints.maxWidth,
        child: InkWell(
          borderRadius: BorderRadius.circular(constraints.maxWidth),

          onTap: () {},
          child: Column(
            spacing: 4,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: GradientBoxBorder(gradient: Grad.shadowGrad(false)),
                  shape: BoxShape.circle,
                ),
                child: ClipOval(
                  child: Image.asset(Assets.assetsPngFastFood, fit: BoxFit.cover, height: constraints.maxWidth),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    "Fast Food Category one",
                    style: TStyle.blackSemi(13),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
