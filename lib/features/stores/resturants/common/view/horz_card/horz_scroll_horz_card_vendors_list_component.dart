import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/stores/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/stores/resturants/common/view/horz_card/horizontal_vendor_card.dart';
import 'package:gazzer/features/stores/domain/generic_vendor_entity.dart';

class HorzScrollHorzCardVendorsListComponent<T> extends StatelessWidget {
  const HorzScrollHorzCardVendorsListComponent({
    super.key,
    this.corner = Corner.bottomRight,
    required this.title,
    required this.items,
    this.onViewAllPressed,
  }) : assert(
         items is List<GenericVendorEntity>  || items is List<PlateEntity>,
         'HorzScrollHorzCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final Corner corner;
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
          if (title != null || onViewAllPressed != null)
            TitleWithMore(
              title: title ?? '',
              onPressed: onViewAllPressed,
            ),

          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              itemCount: items.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final item = items[index];
                if (item is RestaurantEntity) {
                  return HorizontalVendorCard(
                    corner: corner,
                    imgToTextRatio: 0.8,
                    width: 260,
                    vendor: items[index] as RestaurantEntity,
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
