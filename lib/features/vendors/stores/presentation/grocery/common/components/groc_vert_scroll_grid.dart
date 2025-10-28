import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_switcher.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';

class GrocVertScrollGrid<T> extends StatelessWidget {
  /// [childAspectRatio] and [corner] has no role
  const GrocVertScrollGrid({
    super.key,
    required this.title,
    required this.onViewAllPressed,
    required this.items,
    this.cardWidth,
    this.cardHeight,
    this.childAspectRatio,
    this.canScroll = false,
    required this.onSinglceCardPressed,
    required this.shrinkWrap,
    this.gridDelegate,
    required this.shape,
  }) : assert(
         items is List<GenericVendorEntity> || items is List<GenericItemEntity>,
         'HorzScrollVertCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final bool shrinkWrap;
  final String? title;
  final Function()? onViewAllPressed;
  final Function(T item) onSinglceCardPressed;
  final List<T> items;
  final double? cardWidth;
  final double? cardHeight;
  final double? childAspectRatio;
  final bool canScroll;
  final SliverGridDelegate? gridDelegate;
  final CardStyle shape;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 16,
        children: [
          TitleWithMore(
            title: title ?? '',
            onPressed: items.length > 10 ? onViewAllPressed : null,
          ),
          GridView.builder(
            physics: canScroll ? null : const NeverScrollableScrollPhysics(),

            shrinkWrap: shrinkWrap,
            padding: EdgeInsets.zero,
            itemCount: items.length,
            gridDelegate:
                gridDelegate ??
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: childAspectRatio ?? 0.53,
                ),
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is StoreEntity) {
                return GrocCardSwitcher<StoreEntity>(
                  width: cardWidth ?? 140,
                  entity: item,
                  onPressed: () => onSinglceCardPressed(item),
                  height: cardHeight,
                  cardStyle: CardStyle.typeOne,
                );
              }
              if (item is ProductEntity) {
                return GrocProdCard(
                  product: item,
                  shape: shape,
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
