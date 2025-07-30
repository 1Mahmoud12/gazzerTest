import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({super.key, required this.image});
  final String image;
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
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            SizedBox.expand(child: CustomNetworkImage(image, fit: BoxFit.cover)),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: DecoratedFavoriteWidget(size: 24, borderRadius: AppConst.defaultBorderRadius),
            ),
          ],
        ),
      ),
    );
  }
}
