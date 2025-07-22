import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';
import 'package:gazzer/features/stores/resturants/common/view/vert_card/vertical_vendor_card.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';

class VerticalVendorGridComponent<T> extends StatelessWidget {
  const VerticalVendorGridComponent({super.key, required this.title, this.onViewAllPressed, required this.items})
    : assert(
        items is List<RestaurantEntity> || items is List<PlateEntity>,
        'HorzScrollVertCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
      );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      child: Column(
        children: [
          TitleWithMore(
            title: title ?? '',
            onPressed: onViewAllPressed,
          ),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),

            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 220,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is RestaurantEntity) {
                return VerticalVendorCard(width: 350, height: 150, vendor: item, corner: Corner.bottomLeft);
              }
              if (item is PlateEntity) return const SizedBox();
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
