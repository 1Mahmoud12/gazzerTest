import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/vendor_info_widget.dart';

class GrocCardTwo extends StatelessWidget {
  const GrocCardTwo({
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
        onPressed: vendor.isClosed ? null : onPressed,
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
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(color: Color(0x442A003C), offset: Offset(0, 4), blurRadius: 4),
                        ],
                      ),
                      child: DecoratedBox(
                        decoration: vendor.isClosed
                            ? BoxDecoration(color: Colors.red.withAlpha(75), shape: BoxShape.circle)
                            : const BoxDecoration(shape: BoxShape.circle),
                        child: CustomNetworkImage(
                          vendor.image,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          borderReduis: 150,
                          width: double.infinity,
                          opacity: vendor.isClosed ? 0.4 : 1,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.topEnd,
                    child: DecoratedBox(
                      decoration: const BoxDecoration(color: Co.second2, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          '30%',
                          style: TStyle.primaryBold(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(flex: 4, child: VendorInfoWidget(vendor: vendor)),
          ],
        ),
      ),
    );
  }
}
