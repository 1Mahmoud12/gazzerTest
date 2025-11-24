part of '../single_cat_restaurant_details.dart';

class _FoodImagesGallery extends StatefulWidget {
  const _FoodImagesGallery({required this.plates, required this.onSelect, required this.selected});
  final List<PlateEntity> plates;
  final Future<bool> Function(PlateEntity) onSelect;
  final PlateEntity selected;

  @override
  State<_FoodImagesGallery> createState() => _FoodImagesGalleryState();
}

class _FoodImagesGalleryState extends State<_FoodImagesGallery> {
  late PlateEntity selected;

  @override
  void initState() {
    selected = widget.selected;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final smallImagesWidth = 75.0;
    print(selected.image);
    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [Co.purple.withAlpha(80), Co.bg.withAlpha(0)],
                radius: 0.5,
                stops: const [0.5, 1.0],
              ),
            ),
            child: AspectRatio(
              aspectRatio: 1.1,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 1200),
                layoutBuilder: (currentChild, previousChildren) => SizedBox.expand(child: currentChild),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: child,
                ),
                child: CircleGradientBorderedImage(
                  image: selected.image,
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.85, -0.9),
            child: SizedBox(
              width: smallImagesWidth,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 12),
                itemCount: widget.plates.length,
                separatorBuilder: (context, index) => const VerticalSpacing(12),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      if (await widget.onSelect(widget.plates[index])) setState(() => selected = widget.plates[index]);
                    },
                    child: CircleGradientBorderedImage(image: widget.plates[index].image),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
