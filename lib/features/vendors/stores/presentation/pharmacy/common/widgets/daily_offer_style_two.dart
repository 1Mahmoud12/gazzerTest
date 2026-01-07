// import 'package:flutter/material.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';

// import 'package:gazzer/core/presentation/extensions/color.dart';
// import 'package:gazzer/core/presentation/localization/l10n.dart';
// import 'package:gazzer/core/presentation/theme/app_theme.dart';
// import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
// import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
// import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
// import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
//
// /// Daily offer style one widget - Product card with discount and multiple product images
// class DailyOfferStyleTwo extends StatelessWidget {
//   const DailyOfferStyleTwo({super.key, required this.product, this.discountPercentage = 30, this.onTap});
//
//   final ProductEntity product;
//   final int discountPercentage;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final isAr = L10n.isAr(context);
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//         child: Column(
//           children: [
//             // Top Section - Product Images and Icons
//             _TopSection(product: product, discountPercentage: discountPercentage, isAr: isAr),
//
//             // Bottom Section - Product Details
//             _BottomSection(product: product, isAr: isAr),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _TopSection extends StatelessWidget {
//   const _TopSection({required this.product, required this.discountPercentage, required this.isAr});
//
//   final ProductEntity product;
//   final int discountPercentage;
//   final bool isAr;
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         final width = constraints.maxWidth;
//         return Container(
//           height: 140,
//           width: width,
//           decoration: BoxDecoration(
//             color: Co.bg.withOpacityNew(0.5),
//             borderRadius: isAr
//                 ? const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
//                 : const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
//           ),
//           child: Stack(
//             children: [
//               // Product Images Stack
//               Row(
//                 children: [
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: isAr
//                             ? const BorderRadius.only(topLeft: Radius.circular(60), bottomRight: Radius.circular(60))
//                             : const BorderRadius.only(topRight: Radius.circular(60), bottomLeft: Radius.circular(60)),
//                         border: Border.all(color: Co.buttonGradient.withOpacityNew(.35), width: 2),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: isAr
//                             ? const BorderRadius.only(topLeft: Radius.circular(60), bottomRight: Radius.circular(60))
//                             : const BorderRadius.only(topRight: Radius.circular(60), bottomLeft: Radius.circular(60)),
//                         child: Stack(
//                           children: [
//                             CustomNetworkImage(
//                               height: 140,
//                               width: width,
//                               'https://cdn.thewirecutter.com/wp-content/media/2024/12/ROUNDUP-KOREAN-SKINCARE-2048px-9736-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
//                               fit: BoxFit.cover,
//                             ),
//                             if (product.outOfStock)
//                               Positioned.fill(
//                                 child: Container(
//                                   height: 140,
//                                   width: constraints.maxWidth,
//                                   decoration: BoxDecoration(
//                                     color: Co.closed.withOpacityNew(.4),
//                                     borderRadius: isAr
//                                         ? const BorderRadius.only(topLeft: Radius.circular(60), bottomRight: Radius.circular(60))
//                                         : const BorderRadius.only(topRight: Radius.circular(60), bottomLeft: Radius.circular(60)),
//                                     border: Border.all(color: Co.buttonGradient.withOpacityNew(.35), width: 2),
//                                   ),
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               // Discount Tag
//               if (discountPercentage > 0)
//                 Positioned(
//                   top: 0,
//                   left: isAr ? null : 0,
//                   right: isAr ? 0 : null,
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     decoration: BoxDecoration(
//                       color: Co.buttonGradient,
//                       borderRadius: isAr
//                           ? const BorderRadius.only(topRight: Radius.circular(6), bottomLeft: Radius.circular(6))
//                           : const BorderRadius.only(topLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
//                     ),
//                     child: Text('$discountPercentage%', style: TStyle.burbleBold(14).copyWith(color: Co.secondary)),
//                   ),
//                 ),
//               // Interactive Icons
//               Positioned(
//                 bottom: 0,
//                 right: isAr ? null : 0,
//                 left: isAr ? 0 : null,
//                 child: ClipRRect(
//                   borderRadius: isAr
//                       ? const BorderRadiusGeometry.only(topRight: Radius.circular(20))
//                       : const BorderRadiusGeometry.only(topLeft: Radius.circular(20)),
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     margin: const EdgeInsets.all(4),
//                     decoration: BoxDecoration(
//                       color: Co.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Co.buttonGradient.withOpacityNew(.35), width: 2),
//                       // borderRadius: const BorderRadiusGeometry.only(
//                       //   topLeft: Radius.circular(20),
//                       //   bottomRight: Radius.circular(20),
//                       // ),
//                     ),
//                     child: Column(
//                       children: [
//                         // Cart Icon
//                         CartToIncrementIcon(product: product, iconSize: 12, isDarkContainer: false, isHorizonal: true),
//                         const SizedBox(height: 10),
//
//                         // Favorite Icon
//                         DecoratedFavoriteWidget(
//                           fovorable: product,
//                           ignorePointer: true,
//                           isDarkContainer: false,
//                           size: 16,
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// // class _ProductImagesStack extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: Co.white,
// //         borderRadius: BorderRadius.circular(12),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.15),
// //             blurRadius: 8,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child:
// //     );
// //   }
// // }
//
// class _BottomSection extends StatelessWidget {
//   const _BottomSection({required this.product, required this.isAr});
//
//   final ProductEntity product;
//   final bool isAr;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadiusGeometry.circular(12),
//         gradient: LinearGradient(
//           colors: [Colors.black.withOpacityNew(0), Co.buttonGradient.withOpacityNew(.4)],
//           end: AlignmentDirectional.bottomCenter,
//           begin: AlignmentDirectional.topCenter,
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Product Category
//           Text(isAr ? 'منتج طبي' : 'Medical Product', style: TStyle.burbleRegular(12).copyWith(color: Co.buttonGradient)),
//
//           const SizedBox(height: 8),
//
//           // Delivery Info
//           Text(isAr ? 'توصيل مجاني' : 'Free Delivery', style: TStyle.greyRegular(12).copyWith(color: Co.tertiary)),
//
//           const SizedBox(height: 8),
//
//           // Rating
//           Row(
//             children: [
//               const Icon(Icons.star, color: Co.tertiary, size: 12),
//               const Spacer(),
//               const SizedBox(width: 4),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text('${product.rate.toStringAsFixed(1)} ', style: TStyle.greyBold(12).copyWith(color: Co.tertiary)),
//                   Text(' (${product.reviewCount})', style: TStyle.greyBold(12)),
//                 ],
//               ),
//             ],
//           ),
//
//           const SizedBox(height: 12),
//
//           // Price
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(isAr ? 'السعر' : 'PRICE', style: TStyle.greyRegular(12).copyWith(color: Co.grey)),
//               Text(isAr ? '100 جنيه' : '100 EGP', style: TStyle.robotBlackRegular().copyWith(fontWeight:TStyle.bold).copyWith()),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
