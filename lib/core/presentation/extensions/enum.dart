import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

part 'enum_parser.dart';

enum Corner { topLeft, topRight, bottomLeft, bottomRight }

extension AlignmentCorner on Corner {
  Alignment get alignment {
    switch (this) {
      case Corner.topLeft:
        return Alignment.topLeft;
      case Corner.topRight:
        return Alignment.topRight;
      case Corner.bottomLeft:
        return Alignment.bottomLeft;
      case Corner.bottomRight:
        return Alignment.bottomRight;
    }
  }
}

enum CardStyle {
  /// RestHorzScrollHorzCardListComponent
  typeOne('One'),

  /// RestHorzScrollVertCardListComponent
  typeTwo('Two'),

  /// RestVertScrollHorzCardListComponent
  typeThree('Three'),

  /// RestVertScrollVertCardGridComponent
  typeFour('Four');

  final String type;

  const CardStyle(this.type);

  factory CardStyle.fromString(String type) {
    return CardStyle.values.firstWhere((e) => e.type == type, orElse: () => typeOne);
  }
  static BorderRadius getShapeRadius(CardStyle shape) {
    switch (shape) {
      case CardStyle.typeOne:
        return const BorderRadius.only(
          topRight: Radius.circular(50),
          topLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
          bottomLeft: Radius.circular(50),
        );
      case CardStyle.typeTwo:
        return BorderRadius.circular(100);
      case CardStyle.typeThree:
        return const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100));
      case CardStyle.typeFour:
        return BorderRadius.circular(16);
    }
  }
}

enum LayoutType {
  horizontal('Horizontal'),
  vertical('Vertical'),
  grid('Grid');

  final String type;

  const LayoutType(this.type);

  factory LayoutType.fromString(String type) {
    return LayoutType.values.firstWhere((e) => e.type == type, orElse: () => horizontal);
  }
}

enum DiscountType {
  percentage('percent'),
  fixed('fixed'),
  unkown('unknown');

  final String type;

  const DiscountType(this.type);

  factory DiscountType.fromString(String type) {
    return DiscountType.values.firstWhere((e) => e.type == type, orElse: () => unkown);
  }
}

enum OptionType {
  radio('radio'),
  checkbox('checkbox'),
  unknown('unknown');

  final String value;
  const OptionType(this.value);

  static OptionType fromString(String value) {
    return OptionType.values.firstWhere((e) => e.value == value, orElse: () => unknown);
  }
}

enum FavoriteType {
  restaurant('restaurant'),
  store('store'),
  plate('plate'),
  product('store-item'),
  unknown('unknown');

  final String type;

  const FavoriteType(this.type);

  factory FavoriteType.fromString(String type) {
    return FavoriteType.values.firstWhere((e) => e.type == type, orElse: () => unknown);
  }
  String get trName {
    switch (this) {
      case FavoriteType.restaurant:
        return L10n.tr().favoriteRestaurants;
      case FavoriteType.store:
        return L10n.tr().favoriteStores;
      case FavoriteType.plate:
        return L10n.tr().favoritePlates;
      case FavoriteType.product:
        return L10n.tr().favoriteProducts;
      default:
        return '';
    }
  }
}
