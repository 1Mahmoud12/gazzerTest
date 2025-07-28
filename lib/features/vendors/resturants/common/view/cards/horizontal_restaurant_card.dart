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

class HorizontalRestaurantCard extends StatelessWidget {
  const HorizontalRestaurantCard({
    super.key,
    this.width,
    required this.item,
    this.height,
    this.corner = Corner.bottomRight,
    this.imgToTextRatio = 0.66,
    required this.onTap,
  });
  final double? width;
  final double? height;
  final RestaurantEntity item;
  final Corner corner;
  final double imgToTextRatio;
  final Function(RestaurantEntity)? onTap;

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
          onPressed: item.isClosed
              ? null
              : onTap == null
              ? null
              : () => onTap!(item),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
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
                        child: Stack(
                          children: [
                            Container(
                              foregroundDecoration: !item.isClosed
                                  ? null
                                  : BoxDecoration(color: Colors.red.withAlpha(75)),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item.image),
                                  fit: BoxFit.cover,
                                  opacity: item.isClosed ? 0.4 : 1,
                                  onError: (error, stackTrace) => print(' Error loading image: $error'),
                                ),
                              ),
                            ),
                            if (item.isClosed)
                              CardBadge(
                                text: L10n.tr().closed,
                                alignment: AlignmentDirectional.topStart,
                                fullWidth: true,
                              )
                            else if (item.badge != null)
                              CardBadge(
                                text: item.badge!,
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

              Expanded(flex: 10, child: CardRestInfoWidget(vendor: item)),
            ],
          ),
        ),
      ),
    );
  }
}
