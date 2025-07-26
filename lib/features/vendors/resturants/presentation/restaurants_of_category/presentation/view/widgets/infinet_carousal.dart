import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class LongitudinalCarousal extends StatelessWidget {
  const LongitudinalCarousal(this.images, {super.key});
  // TODO recieve image + on click behavior in a wrapper
  final List<String> images;
  // final controller = InfiniteScrollController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 260,
          viewportFraction: 0.35,
          initialPage: 0,
          enableInfiniteScroll: true,
          // pauseAutoPlayOnManualNavigate: false,
          // pauseAutoPlayOnTouch: false,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          onPageChanged: (a, s) {},
          scrollDirection: Axis.horizontal,
          onScrolled: (value) {},
        ),
        itemCount: images.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AspectRatio(aspectRatio: 2.5, child: Image.asset(images[itemIndex], fit: BoxFit.cover)),
          );
        },
      ),
    );
  }
}
