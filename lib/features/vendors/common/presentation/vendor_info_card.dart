import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/date_time.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/dialogs.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_closing_timer.dart';
import 'package:go_router/go_router.dart';

class VendorInfoCard extends StatelessWidget {
  const VendorInfoCard(this.vendor, {super.key, this.padding, required this.categories, required this.onTimerFinish});
  final GenericVendorEntity vendor;
  final EdgeInsets? padding;
  final Iterable<String>? categories;
  final Function(BuildContext ctx) onTimerFinish;

  @override
  Widget build(BuildContext context) {
    if (!vendor.isOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return Dialogs.infoDialog(
              title: L10n.tr().alert,
              message: L10n.tr().thisVendorIsClosedOrBusyRightNow,
              okBgColor: Co.greyText,
              onConfirm: () {
                context.pop();
                context.pop();
              },
            );
          },
        );
      });
    }
    final imageSize = 60.0;
    return ClipRRect(
      borderRadius: AppConst.defaultBorderRadius,
      child: ColoredBox(
        color: Co.secText.withAlpha(100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 4,
                    children: [
                      ClipOval(
                        child: CustomNetworkImage(
                          vendor.image,
                          height: imageSize,
                          width: imageSize,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 12,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: GradientText(text: vendor.name, style: TStyle.blackBold(16)),
                            ),
                            if (categories?.isNotEmpty == true)
                              Text(
                                Helpers.shortIrretableStrings(categories!, 38) ?? '',
                                style: TStyle.greyRegular(12),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (vendor.alwaysOpen)
                              Text(
                                L10n.tr().alwayeysOpen,
                                style: TStyle.blackSemi(13),
                                textAlign: TextAlign.center,
                              )
                            else if (vendor.alwaysClosed)
                              Text(
                                L10n.tr().thisRestaurantIsCurrentlyUnavailable,
                                style: TStyle.blackRegular(11).copyWith(color: Co.darkRed),
                                textAlign: TextAlign.center,
                              )
                            else
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(Icons.access_time, color: Co.purple, size: 18),
                                  Flexible(
                                    child: FittedBox(
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: "${L10n.tr().from}:  ", style: TStyle.primaryBold(12)),
                                            if (vendor.startTime != null)
                                              TextSpan(
                                                text: vendor.startTime!.defaultTimeFormat,
                                                style: TStyle.greyRegular(12),
                                              )
                                            else
                                              TextSpan(
                                                text: L10n.tr().availabilityUnknown,
                                                style: TStyle.greyRegular(12),
                                              ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  const SizedBox.shrink(),
                                  Flexible(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text.rich(
                                        TextSpan(
                                          children: [
                                            TextSpan(text: "${L10n.tr().to}:  ", style: TStyle.primaryBold(12)),
                                            if (vendor.endTime != null)
                                              TextSpan(
                                                text: vendor.endTime!.defaultTimeFormat,
                                                style: TStyle.greyRegular(12),
                                              )
                                            else
                                              TextSpan(
                                                text: L10n.tr().availabilityUnknown,
                                                style: TStyle.greyRegular(12),
                                              ),
                                          ],
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
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
                            fovorable: vendor,
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
            if (!vendor.isClosed)
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (vendor.zoneName.trim().isNotEmpty)
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
                            vendor.zoneName.toUpperCase(),
                            style: TStyle.greyRegular(13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    else
                      const SizedBox.shrink(),
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
                            "${vendor.deliveryTime} ${L10n.tr().min}",
                            style: TStyle.greyRegular(13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    else
                      const SizedBox.shrink(),
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
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            if (vendor.endTime != null && vendor.endTime!.difference(DateTime.now()) < Duration(minutes: vendor.mintsBeforClosingAlert))
              VendorClosingTimer(
                endTime: vendor.endTime!,
                name: vendor.name,
                startTime: vendor.startTime,
                onTimerFinish: (ctx) {},
              ),
          ],
        ),
      ),
    );
  }
}
