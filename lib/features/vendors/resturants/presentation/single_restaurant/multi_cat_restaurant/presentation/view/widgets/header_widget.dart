import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/common/view/app_bar_row_widget.dart';

class MultiCatRestHeader extends StatelessWidget {
  const MultiCatRestHeader({super.key, required this.vendor, required this.categires});
  final RestaurantEntity vendor;
  final Iterable<String>? categires;
  @override
  Widget build(BuildContext context) {
    final height =
        MediaQuery.paddingOf(context).top +
        2 * kToolbarHeight +
        120.0; // 105 is the expected height of vendor info card

    return SizedBox(
      height: height,
      child: Stack(
        alignment: Alignment.bottomCenter,
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
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              AppBarRowWidget(
                showCart: false,
                showNotification: false,
                onShare: () {},
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: VendorInfoCard(
                  vendor,
                  categories: categires,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
