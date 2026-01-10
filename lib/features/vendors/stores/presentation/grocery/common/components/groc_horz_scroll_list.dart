import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_three.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';

class GrocHorzScrollList<T> extends StatelessWidget {
  /// [cardImageToTextRatio] and [corner] has no role
  const GrocHorzScrollList({
    super.key,
    required this.title,
    required this.onViewAllPressed,
    required this.items,
    this.cardWidth,
    this.cardHeight,
    required this.onSinglceCardPressed,
    required this.shape,
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
  final CardStyle shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 4,
        children: [
          TitleWithMore(
            title: title ?? '',
            onPressed: items.length > 10 ? onViewAllPressed : null,
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
                  return GrocCardThree(
                    width: cardWidth ?? 140,
                    vendor: item,
                    onPressed: () => onSinglceCardPressed(item),
                  );
                }
                if (item is ProductEntity) {
                  return GrocProdCard(product: item, shape: shape);
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
