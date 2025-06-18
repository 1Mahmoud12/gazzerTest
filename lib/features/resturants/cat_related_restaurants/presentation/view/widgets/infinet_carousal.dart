part of "../cat_related_restaurants_screen.dart";

class _InfinetAnimatingCarousal extends StatefulWidget {
  const _InfinetAnimatingCarousal();
  @override
  State<_InfinetAnimatingCarousal> createState() => _InfinetAnimatingCarousalState();
}

class _InfinetAnimatingCarousalState extends State<_InfinetAnimatingCarousal> {
  final controller = InfiniteScrollController();
  final images = [Assets.assetsPngSandwitchLayers, Assets.assetsPngSandwtichLayer2];

  Future animate() async {
    while (mounted) {
      await controller.nextItem(duration: const Duration(seconds: 2), curve: Curves.linear);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      animate();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: AbsorbPointer(
        child: InfiniteCarousel.builder(
          itemCount: images.length,
          itemExtent: 160,
          center: true,
          anchor: 0.5,
          velocityFactor: 0.2,
          controller: controller,
          axisDirection: Axis.horizontal,
          loop: true,
          itemBuilder: (context, itemIndex, realIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: AspectRatio(aspectRatio: 2.5, child: Image.asset(images[itemIndex], fit: BoxFit.cover)),
            );
          },
        ),
      ),
    );
  }
}
