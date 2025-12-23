import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/card_badge.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/vendor_info_widget.dart';

class GrocCardOne extends StatelessWidget {
  const GrocCardOne({super.key, required this.width, required this.vendor, this.height, this.onPressed});
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
        onPressed: !vendor.isOpen ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
          padding: EdgeInsetsGeometry.zero,
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: AppConst.defaultStoreBorderRadius,
              child: Stack(
                children: [
                  CustomNetworkImage(vendor.image, fit: BoxFit.cover, width: 100, height: 100, borderRaduis: 12),

                  if (!vendor.isOpen)
                    CardBadge(text: L10n.tr().closed, fullWidth: true, alignment: AlignmentDirectional.topStart)
                  else if (vendor.badge != null)
                    CardBadge(text: vendor.badge!, alignment: AlignmentDirectional.topStart),
                ],
              ),
            ),
            const VerticalSpacing(8),
            VendorInfoWidget(vendor: vendor),
          ],
        ),
      ),
    );
  }
}
