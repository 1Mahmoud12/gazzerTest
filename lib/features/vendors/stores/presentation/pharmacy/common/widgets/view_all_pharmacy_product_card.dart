// import 'package:flutter/material.dart';
// import 'package:gazzer/core/presentation/theme/app_theme.dart';
// import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
// import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
// import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
// import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
//
// /// Reusable circular product card for pharmacy best sellers
// class ViewAllPharmacyProductCard extends StatelessWidget {
//   const ViewAllPharmacyProductCard({super.key, required this.product, required this.vendorName, this.width, this.onTap});
//
//   final ProductEntity product;
//   final String vendorName;
//   final double? width;
//   final VoidCallback? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     // Calculate dimensions based on the provided width or a default size
//     final cardWidth = width ?? MediaQuery.sizeOf(context).width * 0.45;
//     final imageWidth = cardWidth * 0.44; // 44% of card width (was 0.2 of screen)
//     final imageHeight = cardWidth * 0.22; // Proportional to card width
//     final nameWidth = cardWidth * 0.67; // 67% of card width (was 0.3 of screen)
//     final padding = cardWidth * 0.04; // 4% of card width (was 8)
//     final borderRadius = cardWidth * 0.06; // Proportional border radius (was 12)
//     final fontSize = cardWidth * 0.065; // Base font size proportional to width
//     final smallFontSize = cardWidth * 0.055; // Small font size
//     final iconSize = cardWidth * 0.08; // Icon size proportional to width
//     final smallIconSize = cardWidth * 0.06; // Small icon size
//     final spacing = cardWidth * 0.06; // Spacing proportional to width
//     final smallSpacing = cardWidth * 0.02; // Small spacing
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: cardWidth,
//         padding: EdgeInsets.all(padding),
//         decoration: BoxDecoration(
//           color: Co.buttonGradient.withOpacity(.1), // Light purple background
//           borderRadius: BorderRadius.circular(borderRadius),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Main circular container with product and info
//             // Large circular container
//             Expanded(
//               flex: 1,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Circular border container
//                   Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Co.buttonGradient.withOpacity(.35), width: 3),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // Product Image
//                         ClipOval(
//                           child: Padding(
//                             padding: EdgeInsets.all(padding * 2.5),
//                             child: CustomNetworkImage(
//                               'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', //product.image,
//                               width: imageWidth,
//                               height: imageHeight,
//                               fit: BoxFit.fitHeight,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: smallSpacing),
//
//                         // Product Name
//                         SizedBox(
//                           width: nameWidth,
//                           child: Text(
//                             product.name,
//                             style: TStyle.burbleBold(fontSize),
//                             textAlign: TextAlign.center,
//                             maxLines: 3,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         SizedBox(height: spacing),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Rating and actions
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Column(
//                         children: [
//                           DecoratedFavoriteWidget(
//                             ignorePointer: true,
//                             fovorable: product,
//                             isDarkContainer: false,
//                             size: smallIconSize,
//                             borderRadius: BorderRadius.circular(100),
//                           ),
//                           SizedBox(height: spacing),
//
//                           Text('EG', style: TStyle.blackBold(smallFontSize)),
//                           SizedBox(height: spacing),
//                           Icon(Icons.star, color: Co.secondary, size: iconSize),
//                         ],
//                       ),
//                       Column(
//                         children: [
//                           CartToIncrementIcon(isHorizonal: false, product: product, iconSize: iconSize, isDarkContainer: false),
//                           SizedBox(height: spacing),
//
//                           Text(product.price.toStringAsFixed(0), style: TStyle.blackBold(smallFontSize)),
//                           SizedBox(height: spacing),
//                           Text(product.rate.toStringAsFixed(2), style: TStyle.blackBold(smallFontSize).copyWith(color: Co.secondary)),
//                         ],
//                       ),
//                     ],
//                   ),
//
//                   const Spacer(),
//
//                   Text(vendorName, style: TStyle.greyRegular(fontSize), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
//                   SizedBox(height: spacing),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
