import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';
import 'package:gazzer/features/stores/resturants/common/view/horz_card/horizontal_vendor_card.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';

class VertScrollHorzCardVendorsListComponent<T> extends StatelessWidget {
  const VertScrollHorzCardVendorsListComponent({super.key, this.title, this.onViewAllPressed, required this.items})
    : assert(
        items is List<RestaurantEntity> || items is List<PlateEntity>,
        'HorzScrollHorzCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
      );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
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

          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (context, index) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              final item = items[index];
              if (item is RestaurantEntity) {
                return HorizontalVendorCard(
                  imgToTextRatio: 1.4,
                  // width: 350,
                  height: 115,
                  vendor: item as RestaurantEntity,
                  corner: Corner.topLeft,
                );
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
