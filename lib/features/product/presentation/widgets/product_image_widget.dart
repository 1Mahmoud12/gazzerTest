import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/widgets/products/favorite_widget.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Co.purple.withAlpha(80), Co.bg.withAlpha(0)],
          radius: 0.5,
          stops: const [0.5, 1.0],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: kToolbarHeight),
        child: AspectRatio(
          aspectRatio: 1,
          child: Stack(
            children: [
              SizedBox.expand(child: Image.asset(Assets.assetsPngSandwitch2, fit: BoxFit.cover)),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: Grad.radialGradient,
                      borderRadius: AppConst.defaultBorderRadius,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: Grad.linearGradient,
                        borderRadius: AppConst.defaultBorderRadius,
                      ),
                      child: const FavoriteWidget(size: 24),
                    ),
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
