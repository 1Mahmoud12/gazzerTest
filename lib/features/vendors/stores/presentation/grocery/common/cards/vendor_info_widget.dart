import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

class VendorInfoWidget extends StatelessWidget {
  const VendorInfoWidget({super.key, required this.vendor});
  final StoreEntity vendor;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Co.buttonGradient.withAlpha(30), Colors.black.withAlpha(0)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
        borderRadius: AppConst.defaultBorderRadius,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
        child: Column(
          spacing: 4,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    vendor.name,
                    style: TStyle.primaryBold(14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                DecoratedFavoriteWidget(
                  isDarkContainer: false,
                  size: 18,
                  borderRadius: AppConst.defaultInnerBorderRadius,
                  fovorable: vendor,
                ),
              ],
            ),
            if (vendor.tag?.isNotEmpty == true)
              Text(
                vendor.tag!.join(', '),
                style: TStyle.greyRegular(12),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            if (vendor.totalOrders != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${L10n.tr().totalOrders}: ', style: TStyle.blackRegular(13)),
                  const Spacer(
                    flex: 1,
                  ),
                  Text(
                    vendor.totalOrders.toString(),
                    style: TStyle.blackRegular(12),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            if (vendor.estimatedDeliveryTime != null)
              Row(
                spacing: 4,
                children: [
                  SvgPicture.asset(
                    Assets.assetsSvgTruck,
                    height: 24,
                    width: 24,
                    colorFilter: const ColorFilter.mode(Co.purple, BlendMode.srcIn),
                  ),
                  const Spacer(),
                  Text(
                    "${vendor.estimatedDeliveryTime} ${L10n.tr().min}",
                    style: TStyle.greyRegular(13),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                ],
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
                Text("(${vendor.rateCount ?? 0})", style: TStyle.blackSemi(11)),
                const Spacer(),
              ],
            ),
            if (vendor.zoneName.trim().isNotEmpty)
              Row(
                children: [
                  const Icon(Icons.location_on, size: 24),
                  Expanded(
                    child: Text(
                      vendor.zoneName,
                      style: TStyle.greySemi(12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            if (vendor.deliveryTime != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.access_time_outlined, color: Co.purple, size: 20),
                  const Spacer(),
                  Text("${vendor.deliveryTime} ${L10n.tr().min}", style: TStyle.greySemi(12)),
                  const Spacer(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
