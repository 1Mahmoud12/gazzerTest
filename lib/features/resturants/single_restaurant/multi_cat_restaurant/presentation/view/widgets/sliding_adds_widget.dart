part of '../multi_cat_restaurant_screen.dart';

class _SlidingAddsWidget extends StatelessWidget {
  const _SlidingAddsWidget();

  @override
  Widget build(BuildContext context) {
    final images = [Assets.assetsPng30perc, Assets.assetsPng40perc, Assets.assetsPng50perc];
    return OverlapingCardsSlider(
      itemCount: images.length,
      builder: (context, index) {
        return SizedBox(
          height: 180,
          child: Image.asset(images[index], width: double.infinity, height: 180, fit: BoxFit.cover),
        );
      },
    );
  }
}
