import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/conrer_indented_clipper.dart';
import 'package:gazzer/core/presentation/utils/corner_indendet_shape.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/stacked_item_widget.dart';
import 'package:gazzer/features/stores/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/stores/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';

class HorizontalVendorCard extends StatelessWidget {
  const HorizontalVendorCard({
    super.key,
    this.width,
    required this.vendor,
    this.height,
    this.corner = Corner.bottomRight,
    this.imgToTextRatio = 0.66,
  });
  final double? width;
  final double? height;
  final RestaurantEntity vendor;
  final Corner corner;
  final double imgToTextRatio;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Co.buttonGradient.withAlpha(30), Colors.black.withAlpha(0)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        child: ElevatedButton(
          onPressed: () {
            if (vendor.id.isEven) {
              AppNavigator().push(SingleCatRestaurantScreen(vendorId: vendor.id));
            } else {
              context.myPush(MultiCatRestaurantsScreen(vendorId: vendor.id));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            padding: const EdgeInsetsGeometry.all(8),
          ),
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                flex: (imgToTextRatio * 10).toInt(),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomPaint(
                      isComplex: true,
                      foregroundPainter: CornerIndendetShape(indent: const Size(36, 36), corner: corner),
                      child: ClipPath(
                        clipper: ConrerIndentedClipper(indent: const Size(36, 36), corner: corner),
                        child: Image.network(
                          vendor.image,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.info, color: Co.red),
                        ),
                      ),
                    ),
                    Align(alignment: corner.alignment, child: const DecoratedFavoriteWidget(size: 24, padding: 4)),
                  ],
                ),
              ),

              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vendor.name, style: TStyle.primaryBold(12)),
                    Row(
                      spacing: 4,
                      children: [
                        const Icon(Icons.star, color: Co.tertiary, size: 24),
                        const Spacer(),
                        Text(vendor.rate.toStringAsFixed(2), style: TStyle.blackBold(12).copyWith(color: Co.tertiary)),
                        Text("(${vendor.reviewCount})", style: TStyle.blackSemi(12)),
                      ],
                    ),
                    StackedImagesWidget(images: vendor.categoryOfPlate?.map((e) => e.image).toList() ?? []),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.access_time_outlined, color: Co.purple, size: 24),
                        Text(vendor.estimateDeliveryTime, style: TStyle.greyBold(12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
