import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/conrer_indented_clipper.dart';
import 'package:gazzer/core/presentation/utils/corner_indendet_shape.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/card_badge.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/card_plate_info_widget.dart';

class VerticalPlateCard extends StatelessWidget {
  const VerticalPlateCard({
    super.key,
    required this.width,
    required this.item,
    this.height,
    Corner? corner,
    this.imgToTextRatio = 0.66,
    required this.onTap,
  }) : corner = corner ?? Corner.bottomLeft;
  final double width;
  final double? height;
  final PlateEntity item;
  final Corner corner;
  final double imgToTextRatio;
  final double iconsWidth = 72;
  final Function(PlateEntity)? onTap;

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
          onPressed: item.outOfStock
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
                      foregroundPainter: CornerIndendetShape(indent: Size(iconsWidth, 36), corner: corner),
                      child: ClipPath(
                        clipper: ConrerIndentedClipper(indent: Size(iconsWidth, 36), corner: corner),
                        child: Stack(
                          children: [
                            Container(
                              foregroundDecoration: !item.outOfStock ? null : BoxDecoration(color: Co.secText.withAlpha(200)),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item.image),
                                  fit: BoxFit.cover,
                                  // opacity: item.outOfStock ? 0.4 : 1,
                                  onError: (error, stackTrace) => print(' Error loading image: $error'),
                                ),
                              ),
                            ),
                            if (item.outOfStock)
                              CardBadge(
                                text: L10n.tr().notAvailable,
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
                      child: SizedBox(
                        width: iconsWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const DecoratedFavoriteWidget(size: 24, padding: 4),
                            AbsorbPointer(
                              absorbing: item.outOfStock,
                              child: AddIcon(
                                onTap: () {
                                  if (onTap != null) onTap!(item);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(flex: 10, child: CardPlateInfoWidget(plate: item)),
            ],
          ),
        ),
      ),
    );
  }
}
