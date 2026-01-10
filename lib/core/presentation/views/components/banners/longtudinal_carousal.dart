import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';

class LongitudinalCarousal extends StatelessWidget {
  const LongitudinalCarousal(this.images, {super.key});
  // TODO recieve image + on click behavior in a wrapper
  final List<String> images;
  // final controller = InfiniteScrollController();
  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 260,
        viewportFraction: 0.35,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        onPageChanged: (a, s) {},
        onScrolled: (value) {},
      ),
      itemCount: images.length,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: AspectRatio(
            aspectRatio: 2.5,
            child: CustomNetworkImage(images[itemIndex], fit: BoxFit.cover),
          ),
        );
      },
    );
  }
}
