import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/card_badge.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/vendor_info_widget.dart';

class GrocCardOne extends StatelessWidget {
  const GrocCardOne({
    super.key,
    required this.width,
    required this.vendor,
    this.height,
    this.onPressed,
  });
  final double width;
  final double? height;
  final StoreEntity vendor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
          padding: const EdgeInsetsGeometry.all(0),
          disabledBackgroundColor: Colors.transparent,
        ),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  border: GradientBoxBorder(
                    gradient: Grad().shadowGrad(),
                  ),

                  borderRadius: AppConst.defaultStoreBorderRadius,
                ),
                child: ClipRRect(
                  borderRadius: AppConst.defaultStoreBorderRadius,
                  child: Stack(
                    children: [
                      SizedBox.expand(
                        child: CustomNetworkImage(
                          vendor.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const CardBadge(text: '30%', alignment: AlignmentDirectional.topStart),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 4, child: VendorInfoWidget(vendor: vendor)),
          ],
        ),
      ),
    );
  }
}
