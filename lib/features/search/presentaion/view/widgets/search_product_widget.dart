import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
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
      child: Container(
        width: 125,
        padding: const EdgeInsets.all(8.0),

        child: Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Badge(
              alignment: Alignment.topLeft,
              isLabelVisible: product.badge?.trim().isNotEmpty == true,
              offset: const Offset(-4, 0),
              backgroundColor: Colors.transparent,
              label: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Co.secondary,
                  borderRadius: BorderRadiusGeometry.directional(topStart: Radius.circular(12), bottomEnd: Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                  child: Text(product.badge ?? '', style: TStyle.robotBlackSmall().copyWith(color: Co.purple)),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
                child: CustomNetworkImage(product.image, width: 105, height: 70, fit: BoxFit.cover, borderRaduis: 6),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Co.white,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(
                    product.name,
                    style: TStyle.robotBlackRegular().copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      const VectorGraphicsWidget(Assets.starRateIc, width: 20, height: 20),
                      Text(product.rate.toStringAsFixed(1), style: TStyle.robotBlackRegular().copyWith(fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Row(
                    children: [
                      if (product.offer != null)
                        Text(
                          Helpers.getProperPrice(product.offer!.priceAfterDiscount(product.price)),
                          style: TStyle.greyRegular(12).copyWith(decoration: TextDecoration.lineThrough),
                        ),
                      Text(Helpers.getProperPrice(product.price), style: TStyle.blackRegular(12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
