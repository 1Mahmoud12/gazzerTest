import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart' show AppConst;
import 'package:gazzer/core/presentation/theme/app_theme.dart' show TStyle, Co;
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/product_shape_painter.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show VerticalSpacing;
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/bus/cart_bus.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

import 'circle_gradient_image.dart';
import 'smart_cart_widget.dart';

class VerticalRotatedImgCard extends StatelessWidget {
  const VerticalRotatedImgCard({
    super.key,
    required this.prod,
    required this.onTap,
  });
  final GenericItemEntity prod;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 125,
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: onTap,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: Session().client != null ? 180 : 150,
                width: double.infinity,
                child: CustomPaint(
                  painter: ProductShapePaint(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4, 0, 4, 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          spacing: 6,
                          children: [
                            SizedBox(
                              height: 30,
                              child: CircleGradientBorderedImage(
                                image: prod.image,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                prod.name,
                                style: TStyle.primaryBold(12),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const VerticalSpacing(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Helpers.getProperPrice(prod.price),
                              style: TStyle.tertiaryBold(12),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Co.secondary,
                                  size: 16,
                                ),
                                Text(
                                  prod.rate.toStringAsFixed(1),
                                  style: TStyle.secondarySemi(12),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(
                          L10n.tr().onAllGrills,
                          style: TStyle.blackSemi(12),
                        ),
                        if (Session().client != null) ...[
                          const VerticalSpacing(8),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: SmartCartWidget(
                              product: prod,
                              cartBus: di<CartBus>(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Transform.rotate(
                angle: -0.25,
                child: ClipRRect(
                  borderRadius: AppConst.defaultBorderRadius,
                  child: CustomNetworkImage(
                    prod.image,
                    fit: BoxFit.cover,
                    width: 95,
                    height: 50,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 60,
              right: 0,
              child: DecoratedFavoriteWidget(
                size: 20,
                borderRadius: AppConst.defaultInnerBorderRadius,
                fovorable: prod,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
