import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/card_badge.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/cards/card_rest_info_widget.dart';

class HorizontalRestaurantCard extends StatelessWidget {
  const HorizontalRestaurantCard({
    super.key,
    this.width,
    required this.item,
    this.height,
    this.corner = Corner.bottomRight,
    this.imgToTextRatio = 0.66,
    required this.onTap,
  });
  final double? width;
  final double? height;
  final RestaurantEntity item;
  final Corner corner;
  final double imgToTextRatio;
  final Function(RestaurantEntity)? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: !item.isOpen
            ? null
            : onTap == null
            ? null
            : () => onTap!(item),
        // style: ElevatedButton.styleFrom(
        //   backgroundColor: Colors.transparent,
        //   disabledBackgroundColor: Colors.transparent,
        //   shadowColor: Colors.transparent,
        //   shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
        //   padding: const EdgeInsetsGeometry.all(8),
        // ),
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
                      child: CustomNetworkImage(
                        item.image,
                        fit: BoxFit.cover,
                        height: MediaQuery.sizeOf(context).height * .15,
                        width: double.infinity,
                        opacity: !item.isOpen ? 0.4 : 1,
                      ),
                    ),

                    if (!item.isOpen)
                      CardBadge(text: L10n.tr().closed, alignment: AlignmentDirectional.topStart, fullWidth: true)
                    else if (item.badge != null)
                      CardBadge(
                        text: item.badge!,
                        alignment: corner == Corner.topRight ? AlignmentDirectional.topStart : AlignmentDirectional.topEnd,
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: FavoriteWidget(size: 24, padding: 4, fovorable: item),
                ),
              ],
            ),

            CardRestInfoWidget(vendor: item),
          ],
        ),
      ),
    );
  }
}
