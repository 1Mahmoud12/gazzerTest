import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_closing_timer.dart';
import 'package:intl/intl.dart';

class VendorInfoCard extends StatelessWidget {
  const VendorInfoCard(this.vendor, {super.key});
  final GenericVendorEntity vendor;
  @override
  Widget build(BuildContext context) {
    final imageSize = 70.0;
    return Padding(
      padding: EdgeInsetsGeometry.fromLTRB(16, imageSize * 0.5, 16, 0),
      child: ClipRRect(
        borderRadius: AppConst.defaultBorderRadius,
        child: ColoredBox(
          color: Co.secText.withAlpha(95),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      spacing: 6,
                      children: [
                        ClipOval(
                          child: CustomNetworkImage(vendor.image, height: imageSize, width: imageSize, fit: BoxFit.cover),
                        ),
                        Expanded(
                          child: Column(
                            spacing: 12,
                            children: [
                              GradientText(text: vendor.name, style: TStyle.blackBold(16)),
                              if (vendor.subCategories != null)
                                Text(
                                  vendor.subCategories!.map((e) => e.name).join(', '),
                                  style: TStyle.greyRegular(12),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              Row(
                                children: [
                                  const Icon(Icons.access_time, color: Co.purple, size: 20),
                                  const Spacer(),
                                  if (vendor.startTime != null)
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: "${L10n.tr().from}:  ", style: TStyle.primaryBold(12)),
                                          TextSpan(
                                            text: DateFormat.jm().format(vendor.startTime!),
                                            style: TStyle.greyRegular(12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  const Spacer(flex: 4),
                                  if (vendor.endTime != null)
                                    Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: "${L10n.tr().to}:  ", style: TStyle.primaryBold(12)),
                                          TextSpan(
                                            text: DateFormat.jm().format(vendor.endTime!),
                                            style: TStyle.greyRegular(12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 6,
                          children: [
                            DecoratedFavoriteWidget(
                              isDarkContainer: false,
                              size: 18,
                              padding: 6,
                              borderRadius: AppConst.defaultInnerBorderRadius,
                            ),
                            Row(
                              spacing: 6,
                              children: [
                                const Icon(Icons.star, color: Co.secondary, size: 20),
                                Text(vendor.rate.toStringAsFixed(1), style: TStyle.primaryBold(13)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (vendor.endTime != null && vendor.endTime!.difference(DateTime.now()) < const Duration(minutes: 45))
                VendorClosingTimer(endTime: vendor.endTime!, name: vendor.name)
              else
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          SvgPicture.asset(
                            Assets.assetsSvgLocation,
                            height: 24,
                            width: 24,
                            colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                          ),
                          Text(
                            vendor.location.toUpperCase(),
                            style: TStyle.greyRegular(13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      if (vendor.deliveryTime != null)
                        Row(
                          spacing: 4,
                          children: [
                            SvgPicture.asset(
                              Assets.assetsSvgTruck,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                            ),
                            Text(
                              vendor.deliveryTime!,
                              style: TStyle.greyRegular(13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      if (vendor.deliveryFee != null)
                        Row(
                          spacing: 4,
                          children: [
                            SvgPicture.asset(
                              Assets.assetsSvgMoney,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                            ),
                            Text(
                              Helpers.getProperPrice(vendor.deliveryFee!),
                              style: TStyle.greyRegular(13),
                              overflow: TextOverflow.ellipsis,
                            ),
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
