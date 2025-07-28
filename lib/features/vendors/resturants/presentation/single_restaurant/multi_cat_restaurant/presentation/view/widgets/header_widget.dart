import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';

class MultiCatRestHeader extends StatelessWidget {
  const MultiCatRestHeader({super.key, required this.vendor});
  final RestaurantEntity vendor;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 120.0;

    return SizedBox(
      height: height,
      child: OverflowBox(
        alignment: Alignment.bottomCenter,
        maxWidth: 1306,
        minWidth: 1306,
        maxHeight: 394,
        minHeight: 394,

        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipPath(
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
            VendorInfoCard(vendor),
          ],
        ),
      ),
    );
  }
}
