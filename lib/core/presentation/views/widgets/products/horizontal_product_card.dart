import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/alignment.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show HorizontalSpacing;
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/rating_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';

class HorizontalProductCard extends StatelessWidget {
  const HorizontalProductCard({super.key, required this.product});
  final GenericItemEntity product;
  @override
  Widget build(BuildContext context) {
    final height = 135.0;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 600, maxHeight: height),
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: () => PlateDetailsRoute(id: product.id).push(context),
        child: Stack(
          children: [
            Align(
              alignment: AlignmentLocale.centerEnd(context),
              child: LayoutBuilder(
                builder: (context, constraints) => SizedBox(
                  width: constraints.maxWidth - 55,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: GradientBoxBorder(
                        gradient: LinearGradient(
                          colors: [Co.purple.withAlpha(25), Co.purple],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.5],
                        ),
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                        topLeft: Radius.circular(32),
                        bottomLeft: Radius.circular(32),
                      ),
                    ),
                    child: Row(
                      children: [
                        const HorizontalSpacing(55),
                        Expanded(
                          child: Padding(
                            padding: AppConst.defaultPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Flexible(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: product.name,
                                        ),
                                        const TextSpan(text: '\n'),
                                        TextSpan(
                                          text: product.description,
                                          style: TStyle.blackRegular(12),
                                        ),
                                      ],
                                      style: TStyle.primaryBold(16),
                                    ),
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                AppRatingWidget(product.rate.toStringAsFixed(1), ignoreGesture: true, itemSize: 16),
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(padding: EdgeInsets.zero),
                              icon: DecoratedBox(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: GradientBoxBorder(gradient: Grad().shadowGrad()),
                                  gradient: Grad().bgLinear.copyWith(stops: const [0.0, 1], colors: [const Color(0x55402788), Colors.transparent]),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    Assets.assetsSvgCart,
                                    height: 20,
                                    width: 20,
                                    colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                            DecoratedFavoriteWidget(size: 20, isDarkContainer: false, fovorable: product),
                          ],
                        ),
                        const HorizontalSpacing(12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentLocale.centerStart(context),
              child: SizedBox(
                height: height * 0.75,
                child: CircleGradientBorderedImage(
                  image: product.image,
                  showBorder: false,
                  shadow: const BoxShadow(color: Colors.black38, offset: Offset(0, 2), blurRadius: 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
