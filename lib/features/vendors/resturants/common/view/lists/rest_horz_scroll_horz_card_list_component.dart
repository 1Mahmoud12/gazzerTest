import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/horizontal_plate_card.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/horizontal_restaurant_card.dart';

class RestHorzScrollHorzCardListComponent<T> extends StatelessWidget {
  const RestHorzScrollHorzCardListComponent({
    super.key,
    this.corner = Corner.bottomRight,
    required this.title,
    required this.items,
    this.onViewAllPressed,
    this.imgToTextRatio = 0.8,
    required this.onSingleCardPressed,
  });
  final Corner? corner;
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
  final double imgToTextRatio;
  final void Function(T item) onSingleCardPressed;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        spacing: 4,
        children: [
          if (title != null || onViewAllPressed != null)
            TitleWithMore(
              title: title ?? '',
              onPressed: items.length > 10 ? onViewAllPressed : null,
            ),

          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final item = items[index];
                if (item is RestaurantEntity) {
                  return HorizontalRestaurantCard(
                    corner: corner ?? Corner.bottomRight,
                    imgToTextRatio: imgToTextRatio,
                    width: 260,
                    item: item,
                    onTap: (item) => onSingleCardPressed(items[index]),
                  );
                }
                if (item is PlateEntity) {
                  return HorizontalPlateCard(
                    corner: Corner.bottomRight,
                    item: item,
                    height: 120,
                    width: 300,
                    imgToTextRatio: 1.05,
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
