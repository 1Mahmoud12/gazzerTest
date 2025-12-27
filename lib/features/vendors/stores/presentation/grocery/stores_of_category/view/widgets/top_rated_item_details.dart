import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/presentation/share_service.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';

class TopRatedItemDetails extends StatelessWidget {
  const TopRatedItemDetails({super.key, required this.item, required this.shadowColor, this.showFavorite = false});
  final GenericItemEntity item;
  final ValueNotifier<Color> shadowColor;
  final bool showFavorite;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomNetworkImage(item.image, height: MediaQuery.sizeOf(context).height * .3, width: double.infinity, borderRaduis: 0, fit: BoxFit.cover),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              AppBarRowWidget(
                onShare: () async {
                  animationDialogLoading();
                  final result = await ShareService().generateShareLink(
                    type: ShareEnumType.store_item.name,
                    shareableType: ShareEnumType.store_item.name,
                    shareableId: item.id.toString(),
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
                showNotification: false,
              ),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(item.name, style: TStyle.whiteBold(16).copyWith(fontWeight: TStyle.bolder)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Co.secondary, borderRadius: BorderRadius.circular(24)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(L10n.tr().save, style: TStyle.robotBlackMedium()),
                                  const HorizontalSpacing(6),
                                  Text(
                                    "${item.offer?.discount}${item.offer?.discountType == DiscountType.percentage ? "%" : ""}",
                                    style: TStyle.robotBlackMedium(),
                                  ),
                                ],
                              ),
                            ),
                            FavoriteWidget(fovorable: item, size: 20, backgroundColor: Colors.transparent),
                          ],
                        ),

                        //   ],
                        // ),
                        // Text(item.description, style: TStyle.whiteSemi(14).copyWith(color: Colors.white60)),
                        // Row(
                        //   spacing: 12,
                        //   children: [

                        //     Expanded(
                        //       child: Row(
                        //         spacing: 6,
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           const Icon(Icons.star, color: Co.secondary, size: 20),
                        //           Text(item.rate.toStringAsFixed(2), style: TStyle.secondaryBold(12)),
                        //         ],
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
