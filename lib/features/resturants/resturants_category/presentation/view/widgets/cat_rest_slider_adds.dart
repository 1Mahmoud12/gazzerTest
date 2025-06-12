import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import  'package:gazzer/core/presentation/views/widgets/animations/overlaping_cards_slider.dart';

class CatRestSliderAdds extends StatelessWidget {
  const CatRestSliderAdds({super.key});
  @override
  Widget build(BuildContext context) {
    final images = [Assets.assetsPng30perc, Assets.assetsPng40perc, Assets.assetsPng50perc];
    return OverlapingCardsSlider(
      itemCount: images.length,
      builder: (context, index) {
        return SizedBox(
          height: 180,
          child: Image.asset(images[index], width: double.infinity,
          height: 180,
           fit: BoxFit.cover),
        );
      },
    );
  }
}
