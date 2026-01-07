// import 'dart:math' as math;

// import 'package:flutter/material.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';

// class ShawarmaCarousel extends StatefulWidget {
//   const ShawarmaCarousel({
//     super.key,
//     required this.maxWidth,
//     required this.itemWidth,
//     required this.itemCount,
//     required this.itemBuilder,
//   });
//   final double maxWidth;
//   final double itemWidth;
//   final int itemCount;
//   final Widget Function(BuildContext context, int index) itemBuilder;
//   @override
//   State<ShawarmaCarousel> createState() => _ShawarmaCarouselState();
// }

// class _ShawarmaCarouselState extends State<ShawarmaCarousel> {
//   late final double totalWidth;
//   late final double cardWidth;

//   late final int itemsPerHalfCircle;
//   late final int itemsPerQuarterCircle;
//   late final double ration;
//   late final PageController _controller;

//   @override
//   void initState() {
//     totalWidth = widget.maxWidth;
//     cardWidth = widget.itemWidth;
//     final flooredCount = (totalWidth / cardWidth).floor();
//     print("flooredCount: $flooredCount");
//     itemsPerHalfCircle = flooredCount.isOdd ? flooredCount : flooredCount + 1;
//     print("itemsPerHalfCircle: $itemsPerHalfCircle");
//     itemsPerQuarterCircle = (itemsPerHalfCircle ~/ 2);
//     ration = 1 / (itemsPerHalfCircle - 2);

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       setState(() {});
//     });
//     super.initState();
//   }

//   @override
//   void didChangeDependencies() {
//     _controller = PageController(viewportFraction: ration, initialPage: itemsPerHalfCircle ~/ 2);
//     print("viewportFraction: ${_controller.viewportFraction}");
//     super.didChangeDependencies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(),
//       body: SizedBox(
//         height: 320,
//         width: totalWidth.toDouble(),
//         child: PageView.builder(
//           controller: _controller,
//           // itemCount: widget.itemCount,
//           itemBuilder: (context, index) {
//             return AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 double value = 1.0;
//                 double position = 0.0;
//                 if (_controller.position.haveDimensions) {
//                   print("controller page ${_controller.page}, index: $index");
//                   value = _controller.page! - index;
//                   position = (-1 + ((2 / ((itemsPerQuarterCircle + 1))) * (value).abs())).clamp(-1, 1.0);
//                 }
//                 print("index: $index  value: $position");

//                 // print("index: $index  calculatedVal: ${_getValue()}");
//                 return ColoredBox(
//                   color: Colors.transparent,
//                   child: Stack(
//                     clipBehavior: Clip.none,
//                     fit: StackFit.expand,
//                     children: [
//                       Align(
//                         alignment: Alignment(0, position),
//                         child: Transform.rotate(
//                           angle: -math.pi * (0.5 / (itemsPerQuarterCircle + 1)) * (value),
//                           child: widget.itemBuilder(context, index),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
