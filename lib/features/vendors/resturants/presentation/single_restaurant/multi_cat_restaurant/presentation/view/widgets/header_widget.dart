import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';

class MultiCatRestHeader extends StatelessWidget {
  const MultiCatRestHeader({super.key, required this.restaurant, required this.categires});
  final RestaurantEntity restaurant;
  final Iterable<String>? categires;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + 2 * kToolbarHeight + 120.0; // 105 is the expected height of vendor info card

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          OverflowBox(
            alignment: const Alignment(0, 0.63),
            maxWidth: 1306,
            minWidth: 1306,
            maxHeight: 394,
            minHeight: 394,
            child: ClipPath(
              clipper: AddShapeClipper(),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: Grad().bgLinear.copyWith(
                    colors: [Co.buttonGradient.withAlpha(200), Co.bg.withAlpha(0)],
                    stops: const [0.0, 1],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBarRowWidget(
                  showCart: false,
                  showNotification: false,
                  onShare: () {},
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 40),
                      child: VendorInfoCard(
                        restaurant,
                        categories: categires,
                        onTimerFinish: (ctx) {
                          RestaurantDetailsRoute(id: restaurant.id).pushReplacement(ctx);
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
