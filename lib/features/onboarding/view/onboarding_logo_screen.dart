// import 'package:flutter/material.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';

// import 'package:gazzer/core/presentation/routing/context.dart';
// import 'package:gazzer/core/presentation/localization/l10n.dart';
// import 'package:gazzer/core/presentation/resources/assets.dart';
// import 'package:gazzer/core/presentation/resources/hero_tags.dart';
// import 'package:gazzer/core/presentation/theme/text_style.dart';
// import  'package:gazzer/core/presentation/views/widgets/helper_widgets/main_btn.dart';
// import 'package:gazzer/features/onboarding/view/onboarding_welcome_screen.dart';

// class OnboardingStartScreen extends StatelessWidget {
//   const OnboardingStartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: DecoratedBox(
//         decoration: const BoxDecoration(
//           image: DecorationImage(image: AssetImage(Assets.assetsPngSplash), fit: BoxFit.cover),
//         ),
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             Center(
//               child: SizedBox(
//                 width: 300,
//                 child: AspectRatio(
//                   aspectRatio: 1,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       Hero(
//                         tag: Tags.cloud,
//                         child: Image.asset(Assets.assetsPngCloudLogo, fit: BoxFit.fill, alignment: Alignment.center, color: Colors.white,),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 40),
//                         child: Image.asset(Assets.assetsPngGazzer, width: 200, fit: BoxFit.fitWidth),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 102,
//               right: -15,
//               child: MainBtn(
//                 onPressed: () {
//                   // Navigator.of(context).push(_createRoute());
//                   context.myPush(const OnboardingFirstScreen());
//                 },
//                 text: L10n.tr().start,
//                 textStyle: context.style20500.copyWith(color: Co.white),
//                 padding: const EdgeInsets.all(6),
//                 width: 150,
//                 icon: Icons.arrow_forward_ios_rounded,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Route _createRoute() {
//   //   return PageRouteBuilder(
//   //     transitionDuration: Durations.long4,
//   //     pageBuilder: (context, animation, secondaryAnimation) => const OnboardingFirstScreen(),
//   //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//   //       const begin = Offset(1.0, 0);
//   //       const end = Offset.zero;
//   //       const curve = Curves.fastEaseInToSlowEaseOut;
//   //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//   //       final offsetAnimation = animation.drive(tween);
//   //       return SlideTransition(position: offsetAnimation, child: child);
//   //     },
//   //   );
//   // }
// }
