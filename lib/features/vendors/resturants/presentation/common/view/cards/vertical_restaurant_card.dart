import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
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
    final closed = item.isClosed;
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: closed
            ? null
            : onTap == null
            ? null
            : () => onTap!(item),
        // style: ElevatedButton.styleFrom(
        //   backgroundColor: Colors.transparent,
        //   shadowColor: Colors.transparent,
        //   disabledBackgroundColor: Colors.transparent,
        //   shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
        //   padding: const EdgeInsetsGeometry.all(8),
        // ),
        child: Stack(
          children: [
            Opacity(
              opacity: closed ? 0.7 : 1,

              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      CustomPaint(
                        isComplex: true,
                        foregroundPainter: CornerIndendetShape(indent: const Size(36, 36), corner: corner),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                              child: CustomNetworkImage(item.image, fit: BoxFit.cover, width: double.infinity),
                            ),
                            // if (closed)
                            //   CardBadge(text: L10n.tr().closed, alignment: AlignmentDirectional.topStart, fullWidth: true)
                            if (item.badge != null)
                              CardBadge(
                                text: item.badge!,
                                alignment: corner == Corner.topRight ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
                              ),
                          ],
                        ),
                      ),
                      FavoriteWidget(size: 24, padding: 4, fovorable: item),
                    ],
                  ),
                  CardRestInfoWidget(vendor: item),
                ],
              ),
            ),
            if (closed) Center(child: Text(L10n.tr().closed, style: TStyle.robotBlackTitle())),
          ],
        ),
      ),
    );
  }
}
