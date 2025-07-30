import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/vertical_plate_card.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/vertical_restaurant_card.dart';

class RestHorzScrollVertCardListComponent<T> extends StatelessWidget {
  const RestHorzScrollVertCardListComponent({
    super.key,
    required this.title,
    required this.onViewAllPressed,
    required this.items,
    this.cardWidth,
    this.cardHeight,
    this.cardImageToTextRatio,
    this.corner,
    required this.onSingleCardPressed,
  }) : assert(
         items is List<GenericVendorEntity> || items is List<GenericItemEntity>,
         'HorzScrollVertCardListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
  final double? cardWidth;
  final double? cardHeight;
  final double? cardImageToTextRatio;
  final Corner? corner;
  final void Function(T item) onSingleCardPressed;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 4,
        children: [
          TitleWithMore(
            title: title,
            onPressed: items.length > 10 ? onViewAllPressed : null,
          ),
          SizedBox(
            height: cardHeight ?? 235,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final item = items[index];
                if (item is RestaurantEntity) {
                  return VerticalRestaurantCard(
                    imgToTextRatio: cardImageToTextRatio ?? 0.9,
                    width: cardWidth ?? 140,
                    item: item,
                    corner: corner,
                    onTap: (item) => onSingleCardPressed(items[index]),
                  );
                }
                if (item is PlateEntity) {
                  return VerticalPlateCard(
                    imgToTextRatio: cardImageToTextRatio ?? 0.9,
                    width: cardWidth ?? 140,
                    item: item,
                    corner: corner,
                    onTap: (item) => onSingleCardPressed(items[index]),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
