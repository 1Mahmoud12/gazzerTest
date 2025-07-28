import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/grocery/presentation/store_menu/view/widgets/cards/store_card_three.dart';

class StoreHorzScrollCardOneList<T> extends StatelessWidget {
  const StoreHorzScrollCardOneList({
    super.key,
    required this.title,
    required this.onViewAllPressed,
    required this.items,
    this.cardWidth,
    this.cardHeight,
    this.cardImageToTextRatio,
    this.corner,
    required this.onSinglceCardPressed,
  }) : assert(
         items is List<GenericVendorEntity> || items is List<GenericItemEntity>,
         'HorzScrollVertCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final String? title;
  final Function()? onViewAllPressed;
  final Function(T tiem) onSinglceCardPressed;
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
            height: cardHeight ?? 160,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final item = items[index];
                if (item is StoreEntity) {
                  return StoreCardThree(
                    width: cardWidth ?? 140,
                    vendor: item,
                    onPressed: () => onSinglceCardPressed(item),
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
