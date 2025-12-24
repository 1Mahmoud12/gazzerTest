import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/presentation/share_service.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:intl/intl.dart';

class MultiCatRestHeader extends StatelessWidget {
  const MultiCatRestHeader({super.key, required this.restaurant, required this.categires});
  final RestaurantEntity restaurant;
  final Iterable<String>? categires;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top App Bar with back, favorite, and share buttons
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const CircleAvatar(
                    backgroundColor: Co.lightGrey,
                    child: Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Co.lightGrey,
                      child: FavoriteWidget(size: 24, color: Colors.transparent, padding: 4, fovorable: restaurant),
                    ),
                    const SizedBox(width: 8),
                    CircleAvatar(
                      backgroundColor: Co.lightGrey,
                      child: InkWell(
                        onTap: () async {
                          animationDialogLoading();
                          final result = await ShareService().generateShareLink(
                            type: ShareEnumType.store.name,
                            shareableType: ShareEnumType.store.name,
                            shareableId: restaurant.id.toString(),
                          );
                          closeDialog();
                          switch (result) {
                            case Ok<ShareGenerateResponse>(value: final response):
                              await Clipboard.setData(ClipboardData(text: response.shareLink));
                              if (context.mounted) {
                                Alerts.showToast(L10n.tr().link_copied_to_clipboard, error: false);
                              }
                            case Err<ShareGenerateResponse>(error: final error):
                              if (context.mounted) {
                                Alerts.showToast(error.message);
                              }
                          }
                        },
                        child: const VectorGraphicsWidget(Assets.shareIc),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Restaurant Logo/Image
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacityNew(0.1), blurRadius: 10, offset: const Offset(0, 4))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CustomNetworkImage(restaurant.image, fit: BoxFit.cover, width: 120, height: 120),
          ),
        ),
        const VerticalSpacing(24),
        // Restaurant Name
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(restaurant.name, style: TStyle.robotBlackSubTitle()),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const VectorGraphicsWidget(Assets.starRateIc),
                  const SizedBox(width: 4),
                  Text(restaurant.rate.toStringAsFixed(1), style: TStyle.blackBold(16)),
                  const SizedBox(width: 12),
                  InkWell(
                    onTap: () {
                      // Navigate to reviews
                    },
                    child: Text(L10n.tr().review, style: TStyle.robotBlackRegular14().copyWith(color: Co.purple)),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (restaurant.description.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(restaurant.description, style: TStyle.robotBlackSubTitle(), textAlign: TextAlign.start),
        ],
        // Rating and Review
        const VerticalSpacing(12),
        // Categories/Cuisine Types
        if (categires != null && categires!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              categires!.join(', '),
              style: TStyle.greyRegular(14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        const SizedBox(height: 12),
        // Info Bar
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          decoration: BoxDecoration(color: Co.purple100, borderRadius: BorderRadius.circular(16)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Delivery Time
              _InfoItem(
                title: L10n.tr().deliveryTime,
                icon: const VectorGraphicsWidget(Assets.deliveryTimeIc),
                text: restaurant.deliveryTime ?? '24 h',
              ),
              // Divider
              Container(width: 2, height: 40, color: Co.darkGrey),
              // Delivery Fee
              _InfoItem(
                title: L10n.tr().deliveryFee,
                icon: const VectorGraphicsWidget(Assets.cacheRestaurantIc),
                text: restaurant.deliveryFee != null ? Helpers.getProperPrice(restaurant.deliveryFee!) : '0 EGP',
              ),
              // Divider
              Container(width: 2, height: 40, color: Co.darkGrey),
              // Open Hours
              _InfoItem(
                title: (restaurant.isOpen ? L10n.tr().closed : L10n.tr().open),
                icon: const VectorGraphicsWidget(Assets.cacheClockIc),
                text: restaurant.alwaysOpen
                    ? '24 h'
                    : (restaurant.isOpen ? DateFormat('hh:ss a').format(restaurant.endTime!) : DateFormat('hh:ss a').format(restaurant.startTime!)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.icon, required this.text, required this.title});

  final Widget icon;
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TStyle.robotBlackMedium()),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 8),
            Flexible(
              child: Text(text, style: TStyle.blackSemi(14), maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ],
    );
  }
}
