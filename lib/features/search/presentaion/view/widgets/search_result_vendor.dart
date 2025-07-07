import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:gazzer/core/presentation/routing/custom_page_transition_builder.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/vendor_model.dart';
import 'package:gazzer/features/resturants/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/resturants/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';

class SearchResultVendor extends StatelessWidget {
  const SearchResultVendor({super.key, required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: GradientBoxBorder(gradient: Grad.shadowGrad()),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        child: ClipRRect(
          borderRadius: AppConst.defaultBorderRadius,
          child: InkWell(
            onTap: () {
              if (vendor.id.isEven) {
                final widget = AppTransitions().slideTransition(
                  SingleCatRestaurantScreen(vendorId: vendor.id),
                  start: const Offset(1, 0),
                );
                AppNavigator().push(widget);
              } else {
                context.myPush(MultiCatRestaurantsScreen(vendorId: vendor.id));
              }
            },
            child: Row(
              children: [
                AspectRatio(aspectRatio: 0.95, child: Image.asset(vendor.image, fit: BoxFit.cover)),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        Text(vendor.name, style: TStyle.primaryBold(14)),
                        Text("Fresh fruits", style: TStyle.greyRegular(12)),
                        Row(
                          spacing: 12,
                          children: [
                            Icon(Icons.access_time_rounded, size: 18, color: Co.purple),
                            Text("20 - 30 MIN", style: TStyle.greyRegular(12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DecoratedFavoriteWidget(
                          isDarkContainer: false,
                          borderRadius: AppConst.defaultInnerBorderRadius,
                          size: 18,
                        ),
                        Text("EGP 85 - 250", style: TStyle.blackBold(12)),
                        Row(
                          spacing: 2,
                          children: [
                            Icon(Icons.star, size: 18, color: Co.secondary),
                            Spacer(),
                            Text(vendor.rate.toStringAsFixed(1), style: TStyle.secondaryBold(12)),
                            Text("(100)", style: TStyle.blackSemi(12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
