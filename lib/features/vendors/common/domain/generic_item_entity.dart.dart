import 'dart:ui';

import 'package:gazzer/core/presentation/extensions/enum.dart';

export 'package:gazzer/core/presentation/extensions/enum.dart';

part 'package:gazzer/features/vendors/resturants/domain/enities/plate_entity.dart';
part 'package:gazzer/features/vendors/stores/domain/entities/product_entity.dart';

/// generic class for both [PlateEntity] for restaurants and [ProductEntity] for stores
sealed class GenericItemEntity {
  final int id;
  final String name;
  final String image;
  final String description;
  final double _price;
  final double rate;
  final double reviewCount;
  final bool outOfStock;
  final String? badge;
  final List<String>? tags;
  final Offer? offer;

  double get price => offer?.priceAfterDiscount(_price) ?? _price;
  double? get priceBeforeDiscount => offer == null ? null : _price;

  const GenericItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required double price,
    required this.rate,
    required this.reviewCount,
    required this.outOfStock,
    this.badge,
    this.tags,
    this.offer,
  }) : _price = price;
}

class Offer {
  final int id;
  final String? expiredAt;
  final double discount;
  final DiscountType discountType;

  Offer({
    required this.id,
    this.expiredAt,
    required this.discount,
    required this.discountType,
  });
  double priceAfterDiscount(double price) {
    return switch (discountType) {
      DiscountType.percentage => price - (price * discount / 100),
      DiscountType.fixed => price - discount,
      _ => price, // No discount
    };
  }
}
