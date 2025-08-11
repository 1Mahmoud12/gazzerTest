import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/cards/vertical_plate_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/cards/vertical_restaurant_card.dart';

class RestVertScrollVertCardGridComponent<T> extends StatelessWidget {
  const RestVertScrollVertCardGridComponent({
    super.key,
    required this.title,
    this.onViewAllPressed,
    required this.items,
    this.corner = Corner.bottomLeft,
    required this.onSingleCardPressed,
  }) : assert(
         items is List<GenericVendorEntity> || items is List<GenericItemEntity>,
         'HorzScrollVertCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
  final Corner? corner;
  final void Function(T item) onSingleCardPressed;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        children: [
          TitleWithMore(
            title: title ?? '',
            onPressed: T is PlateEntity
                ? items.length < 10
                      ? null
                      : onViewAllPressed
                : onViewAllPressed,
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),

            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 235,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is RestaurantEntity) {
                return VerticalRestaurantCard(
                  width: 350,
                  height: 150,
                  item: item,
                  corner: corner,
                  onTap: (item) => onSingleCardPressed(items[index]),
                );
              }
              if (item is PlateEntity) {
                return VerticalPlateCard(
                  item: item,
                  imgToTextRatio: 0.6,
                  width: double.infinity,
                  corner: corner,
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
