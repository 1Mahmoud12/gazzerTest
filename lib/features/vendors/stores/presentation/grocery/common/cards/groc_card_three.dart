import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/conrer_indented_clipper.dart';
import 'package:gazzer/core/presentation/utils/corner_indendet_shape.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class GrocCardThree extends StatelessWidget {
  const GrocCardThree({
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
      width: 140,
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
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomPaint(
                    isComplex: true,
                    foregroundPainter: CornerIndendetShape(
                      indent: const Size(36, 36),
                      corner: Corner.bottomRight,
                    ),
                    child: ClipPath(
                      clipper: ConrerIndentedClipper(indent: const Size(36, 36), corner: Corner.bottomRight),
                      child: PhysicalModel(
                        color: Colors.transparent,
                        elevation: 50,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: ClipPath(
                            clipper: ConrerIndentedClipper(indent: const Size(36, 36), corner: Corner.bottomRight),
                            child: CustomNetworkImage(
                              vendor.image,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Corner.bottomRight.alignment,
                    child: DecoratedFavoriteWidget(
                      size: 24,
                      padding: 4,
                      isDarkContainer: false,
                      borderRadius: BorderRadius.circular(100),
                      fovorable: vendor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              child: Text(
                vendor.name,
                style: TStyle.primaryBold(14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
