// import 'dart:async';

// import 'package:animations/animations.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:gazzer/core/data/resources/fakers.dart';
// import 'package:gazzer/core/presentation/resources/assets.dart';

// class RestCatLastChanceAddWidget extends StatefulWidget {
//   const RestCatLastChanceAddWidget({super.key});

//   @override
//   State<RestCatLastChanceAddWidget> createState() => _RestCatLastChanceAddWidgetState();
// }

// class _RestCatLastChanceAddWidgetState extends State<RestCatLastChanceAddWidget> {
//   int index = 0;
//   late final Timer timer;
//   updateIndex() {
//     setState(() {
//       index++;
//       if (index >= Fakers().fakeProds.length) {
//         index = 0;
//       }
//     });
//   }

//   @override
//   void initState() {
//     timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       updateIndex();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       width: double.infinity,
//       child: Stack(
//         children: [
//           SizedBox.expand(child: SvgPicture.asset(Assets.assetsSvgLastChanceBg, fit: BoxFit.cover)),
//           Align(
//             alignment: const Alignment(0.555, -0.03),
//             child: ClipOval(
//               child: PageTransitionSwitcher(
//                 duration: Durations.long4,
//                 transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
//                   return FadeTransition(opacity: primaryAnimation, child: child);
//                 },
//                 child: Image.asset(key: ValueKey(Fakers().fakeProds[index].image), Fakers().fakeProds[index].image, height: 110, width: 110, fit: BoxFit.cover),
//               ),
//             ),
//           ),
//           Align(
//             alignment: const Alignment(0.83, 0.6),
//             child: ClipOval(
//               child: PageTransitionSwitcher(
//                 duration: Durations.long4,
//                 transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
//                   return FadeTransition(opacity: primaryAnimation, child: child);
//                 },
//                 child: Image.asset(key: ValueKey(Fakers().fakeProds[index].image), Fakers().fakeProds[index].image, height: 60, width: 60, fit: BoxFit.cover),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
