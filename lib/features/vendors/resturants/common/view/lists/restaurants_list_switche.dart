import 'package:flutter/widgets.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_horz_scroll_horz_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_horz_scroll_vert_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_vert_scroll_horz_card_list_component.dart';
import 'package:gazzer/features/vendors/resturants/common/view/lists/rest_vert_scroll_vert_card_grid_component.dart';

class RestaurantsListSwitche<T> extends StatelessWidget {
  const RestaurantsListSwitche({
    super.key,
    this.title,
    this.onViewAllPressed,
    required this.items,
    this.cardWidth,
    this.cardHeight,
    required this.cardImageToTextRatios,
    required this.corners,
    required this.style,
    required this.onSingleCardPressed,
  }) : assert(
         items is List<GenericVendorEntity> || items is List<GenericItemEntity>,
         'HorzScrollHorzCardVendorsListComponent can only be used with RestaurantEntity or PlateEntity',
       );
  final String? title;
  final Function()? onViewAllPressed;
  final List<T> items;
  final double? cardWidth;
  final double? cardHeight;
  final Map<CardStyle, double> cardImageToTextRatios;
  final Map<CardStyle, Corner> corners;
  final CardStyle style;
  final void Function(T item) onSingleCardPressed;

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case CardStyle.typeOne:
        return RestHorzScrollHorzCardListComponent<T>(
          title: title ?? '',
          items: items,
          imgToTextRatio: 0.8,
          onViewAllPressed: onViewAllPressed,
          corner: corners[style],
          onSingleCardPressed: onSingleCardPressed,
        );
      case CardStyle.typeTwo:
        return RestHorzScrollVertCardListComponent<T>(
          title: title ?? '',
          onViewAllPressed: onViewAllPressed,
          items: items,
          cardHeight: cardHeight,
          cardImageToTextRatio: cardImageToTextRatios[style],
          cardWidth: cardWidth,
          corner: corners[style],
          onSingleCardPressed: onSingleCardPressed,
        );
      case CardStyle.typeThree:
        return RestVertScrollHorzCardListComponent<T>(
          title: title ?? '',
          onViewAllPressed: onViewAllPressed,
          items: items,
          cardHeight: cardHeight,
          cardImageToTextRatio: cardImageToTextRatios[style],
          corner: corners[style],
          onSingleCardPressed: onSingleCardPressed,
        );
      case CardStyle.typeFour:
        return RestVertScrollVertCardGridComponent<T>(
          title: title ?? '',
          onViewAllPressed: onViewAllPressed,
          items: items,
          corner: corners[style],
          onSingleCardPressed: onSingleCardPressed,
        );
    }
  }
}
