// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final Widget? trailing;
//   final String? title;
//   final VoidCallback? onBack;
//   final TextStyle? style;
//   final bool showBack;
//   final bool showLogo;
//   final bool showShadow;
//   const MainAppBar({
//     this.trailing,
//     this.title,
//     this.onBack,
//     super.key,
//     this.showLogo = false,
//     this.style,
//     this.showBack = true,
//     this.showShadow = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final canBack = showBack && context.canPop();
//     final boxShadow = [BoxShadow(color: Colors.grey.withAlpha(40), blurRadius: 5, spreadRadius: 5, offset: const Offset(0, 0))];
//     return DecoratedBox(
//       decoration: BoxDecoration(
//         color: Co.white,
//         boxShadow: !showShadow
//             ? null
//             : [
//                 const BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 3, offset: Offset(0, 3)),
//               ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: Column(
//           children: [
//             const VerticalSpacing(14),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: canBack ? onBack ?? (context.canPop() ? () => context.pop() : null) : null,
//                   child: Container(
//                     height: 30,
//                     width: 30,
//                     decoration: !canBack
//                         ? null
//                         : BoxDecoration(
//                             color: Co.white,
//                             borderRadius: BorderRadius.circular(10),
//                             boxShadow: boxShadow,
//                             border: Border.all(color: Co.greyishBlack, width: 1)),
//                     child: Icon(
//                       Icons.arrow_back_ios_new,
//                       color: canBack ? Co.dark : Colors.transparent,
//                       size: 15,
//                     ),
//                   ),
//                 ),
//                 if (showLogo)
//                   Expanded(child: Image.asset(Assets.assetsPngBrand, height: 30, width: 30))
//                 else if (title != null)
//                   Expanded(
//                     child: Text(
//                       title!,
//                       textAlign: TextAlign.center,
//                       overflow: TextOverflow.ellipsis,
//                       style: style ?? TStyle.darkBold(16),
//                     ),
//                   ),
//                 trailing ?? const SizedBox(width: 30),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(55);
// }
