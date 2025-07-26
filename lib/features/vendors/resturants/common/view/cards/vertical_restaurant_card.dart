import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/conrer_indented_clipper.dart';
import 'package:gazzer/core/presentation/utils/corner_indendet_shape.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/card_badge.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/card_rest_info_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';

class VerticalRestaurantCard extends StatelessWidget {
  const VerticalRestaurantCard({
    super.key,
    required this.width,
    required this.vendor,
    this.height,
    Corner? corner,
    this.imgToTextRatio = 0.66,
  }) : corner = corner ?? Corner.bottomRight;
  final double width;
  final double? height;
  final RestaurantEntity vendor;
  final Corner corner;
  final double imgToTextRatio;

  @override
  Widget build(BuildContext context) {
    print(vendor.image);
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
          onPressed: vendor.isClosed
              ? null
              : () {
                  if (vendor.id.isEven) {
                    SingleCatRestaurantRoute(id: vendor.id).push(context);
                  } else {
                    MultiCatRestaurantsRoute(id: vendor.id).push(context);
                  }
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            padding: const EdgeInsetsGeometry.all(8),
          ),
          child: Column(
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
                        child: Stack(
                          children: [
                            Container(
                              foregroundDecoration: !vendor.isClosed
                                  ? null
                                  : BoxDecoration(color: Colors.red.withAlpha(75)),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(vendor.image),
                                  fit: BoxFit.cover,
                                  opacity: vendor.isClosed ? 0.4 : 1,
                                  onError: (error, stackTrace) => print(' Error loading image: $error'),
                                ),
                              ),
                            ),
                            if (vendor.isClosed)
                              CardBadge(
                                text: L10n.tr().closed,
                                alignment: AlignmentDirectional.topStart,
                                fullWidth: true,
                              )
                            else if (vendor.badge != null)
                              CardBadge(
                                text: vendor.badge!,
                                alignment: corner == Corner.topRight
                                    ? AlignmentDirectional.topStart
                                    : AlignmentDirectional.topEnd,
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(alignment: corner.alignment, child: const DecoratedFavoriteWidget(size: 24, padding: 4)),
                  ],
                ),
              ),
              Expanded(flex: 10, child: CardRestInfoWidget(vendor: vendor)),
            ],
          ),
        ),
      ),
    );
  }
}
