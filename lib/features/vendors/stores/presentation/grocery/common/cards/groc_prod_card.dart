import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text_wz_shadow.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class GrocProdCard extends StatelessWidget {
  const GrocProdCard({super.key, required this.product, required this.shape});
  final ProductEntity product;
  final CardStyle shape;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppConst.defaultBorderRadius,
      onTap: () {
        ProductDetailsRoute(productId: product.id).push(context);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                DecoratedBox(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x88FF9F08),
                        offset: Offset(0, 0),
                        blurRadius: 80,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: const Color(0x20504164),
                      borderRadius: CardStyle.getShapeRadius(shape),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsGeometry.all(8),
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: ClipRRect(
                          borderRadius: CardStyle.getShapeRadius(shape),
                          child: CustomNetworkImage(
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: Row(
                    spacing: 6,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecoratedFavoriteWidget(
                        fovorable: product,
                        isDarkContainer: false,
                        size: 18,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: GradientBoxBorder(gradient: Grad().shadowGrad()),
                          borderRadius: BorderRadiusGeometry.circular(100),
                          gradient: Grad().bgLinear.copyWith(
                            stops: const [0.0, 1],
                            colors: [const Color(0x55402788), Colors.transparent],
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.all(6),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                          ),
                          icon: SvgPicture.asset(
                            Assets.assetsSvgCart,
                            height: 20,
                            width: 20,
                            colorFilter: const ColorFilter.mode(
                              Co.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: AppConst.defaultHrPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TStyle.primaryBold(12, font: FFamily.inter),
                  ),

                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Row(
                      spacing: 16,
                      children: [
                        GradientTextWzShadow(
                          text: product.price.toStringAsFixed(2),
                          shadow: AppDec.blackTextShadow.first,
                          style: TStyle.blackBold(12, font: FFamily.inter),
                        ),
                        GradientTextWzShadow(
                          text: L10n.tr().egp,
                          shadow: AppDec.blackTextShadow.first,
                          style: TStyle.blackBold(12, font: FFamily.inter),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Co.secondary, size: 18),
                      const Spacer(),
                      Text(
                        product.rate.toStringAsFixed(1),
                        style: TStyle.secondaryBold(12),
                      ),
                      Text(
                        " ( ${product.reviewCount.toInt()} )",
                        style: TStyle.blackBold(12),
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
