import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class GrocProdCard extends StatelessWidget {
  const GrocProdCard({super.key, required this.product, required this.shape});
  final ProductEntity product;
  final CardStyle shape;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 3,
      child: InkWell(
        borderRadius: AppConst.defaultBorderRadius,
        onTap: () {
          ProductDetailsRoute(productId: product.id).push(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomNetworkImage(
                    product.image,
                    fit: BoxFit.contain,
                    height: 120,
                    width: double.infinity,
                    borderRaduis: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (product.offer == null)
                          const SizedBox()
                        else
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Co.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "${product.offer?.discount}${product.offer?.discountType == DiscountType.percentage ? "%" : ""}",
                              style: context.style16500,
                            ),
                          ),
                        FavoriteWidget(
                          size: 40,
                          fovorable: product,
                          padding: 0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSpacing(4),

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: context.style16500.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(width: 4),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            Assets.starRateIc,
                            width: 16,
                            height: 16,
                          ),
                          const HorizontalSpacing(4),
                          Text(
                            product.rate.toStringAsFixed(1),
                            style: context.style16400,
                          ),
                        ],
                      ),
                    ],
                  ),

                  const VerticalSpacing(4),
                  Text(
                    product.description == ''
                        ? product.name
                        : product.description,
                    style: context.style14400,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  const VerticalSpacing(4),

                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          runSpacing: 4,
                          alignment: WrapAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    Helpers.getProperPrice(product.price),
                                    style: context.style16500.copyWith(
                                      color: Co.purple,
                                    ),
                                  ),
                                ),
                                if (product.offer != null)
                                  FittedBox(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      Helpers.getProperPrice(
                                        product.priceBeforeDiscount!,
                                      ),
                                      style: context.style16500.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Co.greyText,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            CartToIncrementIcon(
                              isHorizonal: true,
                              product: product,
                              iconSize: 25,
                              isDarkContainer: true,
                            ),

                            //CartToIncrementIcon(isHorizonal: false, product: product, iconSize: 20, isDarkContainer: false),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
