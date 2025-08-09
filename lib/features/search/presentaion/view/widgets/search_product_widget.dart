import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/search/domain/search_product_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';

class SearchProductWidget extends StatelessWidget {
  const SearchProductWidget({super.key, required this.product});
  final SearchProductEntity product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (product.type) {
          case ItemType.plate:
            PlateDetailsRoute(id: product.id).push(context);
            break;
          case ItemType.product:
            ProductDetailsRoute(productId: product.id).push(context);
            break;
          default:
            Alerts.showToast('Unknown item type');
            break;
        }
      },
      borderRadius: AppConst.defaultBorderRadius,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: GradientBoxBorder(
            gradient: Grad()
                .shadowGrad(false)
                .copyWith(begin: Alignment.centerLeft, end: Alignment.centerRight, stops: [0.8, 1]),
          ),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        child: SizedBox(
          width: 125,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              spacing: 2,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Badge(
                    alignment: Alignment.topLeft,
                    isLabelVisible: product.badge?.trim().isNotEmpty == true,
                    offset: const Offset(-4, 0),
                    backgroundColor: Colors.transparent,
                    label: DecoratedBox(
                      decoration: const BoxDecoration(
                        color: Co.secondary,
                        borderRadius: BorderRadiusGeometry.directional(
                          topStart: Radius.circular(12),
                          bottomEnd: Radius.circular(12),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                        child: Text(product.badge ?? '', style: TStyle.primarySemi(12)),
                      ),
                    ),
                    child: SizedBox(
                      height: double.infinity,
                      child: CustomNetworkImage(
                        product.image,
                        width: 105,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        borderRaduis: 6,
                      ),
                    ),
                  ),
                ),
                Text(
                  product.name,
                  style: TStyle.primaryBold(12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        Helpers.getProperPrice(product.price),
                        style: TStyle.blackRegular(12),
                      ),
                    ),
                    const Icon(Icons.star, color: Co.secondary, size: 20),
                    Text(
                      product.rate.toStringAsFixed(1),
                      style: TStyle.secondaryBold(12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
