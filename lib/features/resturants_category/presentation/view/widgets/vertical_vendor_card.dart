import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/resturants_category/data/vendor_model.dart';
import 'package:gazzer/features/resturants_category/presentation/view/utils/conrer_indented_clipper.dart';
import 'package:gazzer/features/resturants_category/presentation/view/utils/corner_indendet_shape.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/stacked_item_widget.dart';

class VerticalVendorCard extends StatelessWidget {
  const VerticalVendorCard({
    super.key,
    required this.width,
    required this.vendor,
    this.height,
    this.corner = Corner.bottomRight,
  });
  final double width;
  final double? height;
  final VendorModel vendor;
  final Corner corner;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Co.purple.withAlpha(50), Co.purple.withAlpha(0)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: AppConst.defaultBorderRadius,
        ),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            padding: const EdgeInsetsGeometry.all(8),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomPaint(
                      isComplex: true,
                      foregroundPainter: CornerIndendetShape(indent: const Size(36, 36), corner: corner),
                      child: ClipPath(
                        clipper: ConrerIndentedClipper(indent: const Size(36, 36), corner: corner),
                        child: Image.asset(
                          vendor.imageUrl,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: corner.alignment,
                      child: DoubledDecoratedWidget(
                        innerDecoration: BoxDecoration(borderRadius: BorderRadiusGeometry.circular(6)),
                        child: const Padding(padding: EdgeInsets.all(4), child: FavoriteWidget(size: 24, padding: 0)),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  spacing: 4,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(vendor.name, style: TStyle.primaryBold(16)),
                    Row(
                      spacing: 4,
                      children: [
                        const Icon(Icons.star, color: Co.tertiary, size: 24),
                        const Spacer(),
                        Text(vendor.rate.toStringAsFixed(2), style: TStyle.blackBold(16).copyWith(color: Co.tertiary)),
                        Text("(${vendor.reviewCount})", style: TStyle.blackSemi(16)),
                      ],
                    ),
                    StackedItemWidget(items: vendor.items),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.access_time_outlined, color: Co.purple, size: 24),
                        Text(vendor.deliveryTime, style: TStyle.greyBold(14)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
