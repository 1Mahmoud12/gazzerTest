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
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 185.0;

    return SizedBox(
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          LayoutBuilder(
            builder: (context, constraints) => SizedBox.expand(
              child: FractionallySizedBox(
                alignment: Alignment.bottomCenter,
                heightFactor: 1.5,
                widthFactor: 2.5,
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
            ),
          ),

          Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Column(
              spacing: 12,
              mainAxisSize: MainAxisSize.min,
              children: [
                VendorInfoCard(vendor),
                ClipOval(child: Image.network(vendor.image, height: 125, width: 125, fit: BoxFit.cover)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
