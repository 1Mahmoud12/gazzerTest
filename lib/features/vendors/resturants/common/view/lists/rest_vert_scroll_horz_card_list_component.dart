import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/horizontal_plate_card.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/horizontal_restaurant_card.dart';

class RestVertScrollHorzCardListComponent<T> extends StatelessWidget {
  const RestVertScrollHorzCardListComponent({
    super.key,
    this.title,
    this.onViewAllPressed,
    required this.items,
    this.cardHeight,
    this.cardImageToTextRatio,
    this.corner,
    required this.onSingleCardPressed,
  }) : assert(
         items is List<GenericVendorEntity> || items is List<GenericItemEntity>,
         'HorzScrollHorzCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
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
            title: title ?? '',
            onPressed: items.length > 10 ? onViewAllPressed : null,
          ),

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (context, index) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is RestaurantEntity) {
                return HorizontalRestaurantCard(
                  imgToTextRatio: cardImageToTextRatio ?? 1.4,
                  // width: 350,
                  height: cardHeight ?? 140,
                  item: item as RestaurantEntity,
                  corner: Corner.topLeft,
                  onTap: (item) => onSingleCardPressed(items[index]),
                );
              }
              if (item is PlateEntity) {
                return HorizontalPlateCard(
                  corner: Corner.bottomRight,
                  item: item,
                  height: cardHeight ?? 140,
                  imgToTextRatio: 1.05,
                  onTap: (item) => onSingleCardPressed(items[index]),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
