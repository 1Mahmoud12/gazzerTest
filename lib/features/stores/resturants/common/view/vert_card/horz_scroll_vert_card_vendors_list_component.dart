import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';
import 'package:gazzer/features/stores/resturants/common/view/vert_card/vertical_vendor_card.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';

class HorzScrollVertCardVendorsListComponent<T> extends StatelessWidget {
  const HorzScrollVertCardVendorsListComponent({
    super.key,
    required this.title,
    required this.onViewAllPressed,
    required this.items,
    this.cardWidth,
    this.cardHeight,
    this.cardImageToTextRatio,
    this.corner,
  }) : assert(
         items is List<RestaurantEntity> || items is List<PlateEntity>,
         'HorzScrollVertCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
  final double? cardWidth;
  final double? cardHeight;
  final double? cardImageToTextRatio;
  final Corner? corner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 4,
        children: [
          TitleWithMore(
            title: title ?? '',
            onPressed: onViewAllPressed,
          ),
          SizedBox(
            height: cardHeight ?? 220,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final item = items[index];
                if (item is RestaurantEntity) {
                  return VerticalVendorCard(
                    imgToTextRatio: cardImageToTextRatio ?? 0.9,
                    width: cardWidth ?? 140,
                    vendor: item,
                    corner: corner ?? Corner.bottomRight,
                  );
                }
                if (item is PlateEntity) return const SizedBox();
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
