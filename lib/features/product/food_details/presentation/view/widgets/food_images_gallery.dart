part of '../food_details_screen.dart';

class _FoodImagesGallery extends StatelessWidget {
  const _FoodImagesGallery();

  @override
  Widget build(BuildContext context) {
    final smallImagesWidth = 75.0;
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: [
          Positioned(
            right: -smallImagesWidth,
            top: 0,
            bottom: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Co.purple.withAlpha(80), Co.bg.withAlpha(0)],
                  radius: 0.5,
                  stops: const [0.5, 1.0],
                ),
              ),
              child: AspectRatio(aspectRatio: 1, child: Image.asset(Assets.assetsPngSandwitch2, fit: BoxFit.cover)),
            ),
          ),
          Align(
            alignment: const Alignment(-0.85, -0.9),
            child: SizedBox(
              width: smallImagesWidth,
              child: Padding(
                padding: EdgeInsets.only(top: smallImagesWidth * 0.5),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  separatorBuilder: (context, index) => const VerticalSpacing(12),
                  itemBuilder: (context, index) {
                    return const CircleGradientBorderedImage(image: Assets.assetsPngSandwitch2);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
