import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class StoreCardTwo extends StatelessWidget {
  const StoreCardTwo({
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
              child: Stack(
                children: [
                  SizedBox.expand(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(vendor.image),
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) => print('Error loading image: $exception'),
                        ),
                        boxShadow: [
                          const BoxShadow(color: Color(0x442A003C), offset: Offset(0, 4), blurRadius: 4),
                        ],
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
            Expanded(
              flex: 4,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Co.buttonGradient.withAlpha(30), Colors.black.withAlpha(0)],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius: AppConst.defaultBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  child: Column(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: vendor.name,
                                style: TStyle.primaryBold(14),
                              ),
                              const TextSpan(text: '\n'),
                              TextSpan(
                                text: vendor.description,
                                style: TStyle.greyRegular(12),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      Row(
                        spacing: 4,
                        children: [
                          const Icon(Icons.star, color: Co.tertiary, size: 20),
                          const Spacer(),
                          Text(
                            vendor.rate.toStringAsFixed(2),
                            style: TStyle.blackSemi(12).copyWith(color: Co.tertiary),
                          ),
                          Text("(${vendor.reviewCount})", style: TStyle.blackSemi(11)),
                        ],
                      ),
                      // StackedImagesWidget(images: vendor.categoryOfPlate?.map((e) => e.image).toList() ?? []),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.access_time_outlined, color: Co.purple, size: 20),
                          Text(vendor.estimateDeliveryTime, style: TStyle.greySemi(12)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
