part of '../single_restaurant_details.dart';

class _VendorCard extends StatelessWidget {
  const _VendorCard(this.vendor);
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    final imageSize = 60.0;
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(16, imageSize * 0.5, 16, 0),
      child: SizedBox(
        height: 100,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Co.lightGrey, borderRadius: AppConst.defaultBorderRadius),
              child: Padding(
                padding: EdgeInsets.all(imageSize * 0.25),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 6,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              SvgPicture.asset(
                                Assets.assetsSvgLocation,
                                height: 24,
                                width: 24,
                                colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                              ),
                              Flexible(
                                child: Text(
                                  "4140 Parker Road near by ${vendor.name}",
                                  style: TStyle.blackRegular(13),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          spacing: 2,
                          children: [
                            const Icon(Icons.access_time_rounded, color: Co.purple, size: 20),
                            Text(vendor.deliveryTime, style: TStyle.blackRegular(13)),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Co.purple, size: 20),
                            Text(vendor.rate.toStringAsFixed(1), style: TStyle.primaryBold(13)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -(imageSize * 0.35),
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipOval(
                      child: Image.asset(vendor.image, height: imageSize, width: imageSize, fit: BoxFit.cover),
                    ),
                    GradientText(text: vendor.name, style: TStyle.blackBold(16)),
                    const DecoratedFavoriteWidget(isDarkContainer: false, size: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
