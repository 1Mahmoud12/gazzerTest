import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

/// Card widget for displaying pharmacy vendor information
class PharmacyVendorCard extends StatelessWidget {
  const PharmacyVendorCard({
    super.key,
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.rating,
    required this.reviewCount,
    required this.location,
    required this.deliveryTime,
    this.discountPercentage,
    this.isClosed = false,
    this.isFavorite = false,
    this.onTap,
    this.onFavoriteTap,
  });

  final int id;
  final String name;
  final String logoUrl;
  final double rating;
  final int reviewCount;
  final String location;
  final String deliveryTime;
  final int? discountPercentage;
  final bool isClosed;
  final bool isFavorite;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Opacity(
            opacity: isClosed ? 0.5 : 1,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isClosed ? Co.closedColor.withOpacityNew(.1) : Co.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: isClosed ? Co.purple.withOpacityNew(0.1) : Co.purple.withOpacityNew(0.2), width: 1),
              ),
              child: Row(
                children: [
                  // Logo with discount/closed badge
                  Stack(
                    children: [
                      // Logo
                      Container(
                        width: 100,
                        height: 80,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40)),
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CustomNetworkImage(logoUrl),
                      ),
                      if (discountPercentage != null)
                        Container(
                          margin: const EdgeInsets.all(4),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            '$discountPercentage%',
                            style: TStyle.robotBlackRegular().copyWith(color: Co.black),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(width: 12),

                  // Vendor Information
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: TStyle.robotBlackMedium().copyWith(fontWeight: FontWeight.w700),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const HorizontalSpacing(4),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(rating.toStringAsFixed(1), style: TStyle.robotBlackRegular()),
                                const HorizontalSpacing(4),
                                SvgPicture.asset(Assets.starRateIc, width: 20, height: 20),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          name,
                          style: TStyle.robotBlackSmall().copyWith(color: Co.darkGrey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const VectorGraphicsWidget(
                                  Assets.locationIc,
                                  width: 16,
                                  height: 16,
                                  colorFilter: ColorFilter.mode(Co.secondary, BlendMode.srcIn),
                                ),
                                const SizedBox(width: 4),
                                SizedBox(
                                  width: 60,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(location, style: TStyle.greySemi(12), maxLines: 1, overflow: TextOverflow.ellipsis),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const VectorGraphicsWidget(
                                  Assets.clockIc,
                                  width: 16,
                                  height: 16,
                                  colorFilter: ColorFilter.mode(Co.secondary, BlendMode.srcIn),
                                ),

                                const SizedBox(width: 4),
                                Text(deliveryTime, style: TStyle.greySemi(12)),
                              ],
                            ),
                          ],
                        ),
                        // // Top Rated + Rating
                        // Row(
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //
                        //       children: [
                        //         Text('Top Rated', style: TStyle.mainwSemi(12).copyWith(color: Co.tertiary)),
                        //         const VerticalSpacing(4),
                        //         Row(
                        //           children: [
                        //             const Icon(Icons.location_on, color: Co.purple, size: 16),
                        //             const SizedBox(width: 4),
                        //             SizedBox(
                        //               width: 60,
                        //               child: FittedBox(
                        //                 fit: BoxFit.scaleDown,
                        //                 alignment: AlignmentDirectional.centerStart,
                        //                 child: Text(location, style: TStyle.greySemi(12), maxLines: 1, overflow: TextOverflow.ellipsis),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //
                        //     const Spacer(),
                        //     const SizedBox(width: 8),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Row(
                        //           mainAxisSize: MainAxisSize.min,
                        //           children: [
                        //             const Icon(Icons.star, color: Co.tertiary, size: 18),
                        //             const SizedBox(width: 4),
                        //             Text('$rating ( $reviewCount )', style: TStyle.blackBold(12).copyWith(color: Co.tertiary)),
                        //           ],
                        //         ),
                        //         const VerticalSpacing(4),
                        //
                        //         // Delivery Time
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Favorite Button
                  FavoriteWidget(
                    fovorable: ProductEntity(
                      id: id,
                      name: name,
                      description: 'description',
                      price: 21,
                      image: 'image',
                      rate: 12,
                      reviewCount: reviewCount,
                      outOfStock: false,
                      sold: 0,
                    ),
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          if (isClosed)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(24)),
              child: Text(L10n.tr().closed, style: TStyle.robotBlackSubTitle()),
            ),
        ],
      ),
    );
  }
}
