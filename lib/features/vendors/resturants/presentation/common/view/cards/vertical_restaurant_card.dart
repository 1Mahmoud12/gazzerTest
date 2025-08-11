import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/conrer_indented_clipper.dart';
import 'package:gazzer/core/presentation/utils/corner_indendet_shape.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/card_badge.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/cards/card_rest_info_widget.dart';

class VerticalRestaurantCard extends StatelessWidget {
  const VerticalRestaurantCard({
    super.key,
    required this.width,
    required this.item,
    this.height,
    Corner? corner,
    this.imgToTextRatio = 0.7,
    required this.onTap,
  }) : corner = corner ?? Corner.bottomRight;
  final double width;
  final double? height;
  final RestaurantEntity item;
  final Corner corner;
  final double imgToTextRatio;
  final Function(RestaurantEntity)? onTap;

  @override
  Widget build(BuildContext context) {
    print(item.image);
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
                            DecoratedBox(
                              position: DecorationPosition.foreground,
                              decoration: item.isClosed
                                  ? BoxDecoration(
                                      color: Colors.red.withAlpha(75),
                                    )
                                  : const BoxDecoration(),
                              child: CustomNetworkImage(
                                item.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                opacity: item.isClosed ? 0.4 : 1,
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
                                alignment: corner == Corner.topRight ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
                              ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: corner.alignment,
                      child: DecoratedFavoriteWidget(size: 24, padding: 4, fovorable: item),
                    ),
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
