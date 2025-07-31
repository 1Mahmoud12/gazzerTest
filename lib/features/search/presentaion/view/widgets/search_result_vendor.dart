import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';

class SearchResultVendor extends StatelessWidget {
  const SearchResultVendor({super.key, required this.vendor});
  final RestaurantEntity vendor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          border: GradientBoxBorder(gradient: Grad().shadowGrad()),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        child: ClipRRect(
          borderRadius: AppConst.defaultBorderRadius,
          child: InkWell(
            onTap: () {
              RestaurantDetilsRoute(id: vendor.id).push(context);
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
                        Text(L10n.tr().freshFruits, style: TStyle.greyRegular(12)),
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
                          fovorable: vendor,
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
