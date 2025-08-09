import 'dart:ui';

import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

part 'package:gazzer/features/vendors/resturants/domain/enities/ordered_with_entityy.dart';
part 'package:gazzer/features/vendors/resturants/domain/enities/plate_entity.dart';
part 'package:gazzer/features/vendors/stores/domain/entities/product_entity.dart';

/// generic class for both [PlateEntity] for restaurants and [ProductEntity] for stores or [OrderedWithEntity] for ordered with
sealed class GenericItemEntity extends Favorable {
  final double _price;
  final int reviewCount;
  final bool outOfStock;
  final String? badge;
  final List<String>? tags;
  final OfferEntity? offer;

  double get price => offer?.priceAfterDiscount(_price) ?? _price;
  @override
  double get favorablePrice => offer?.priceAfterDiscount(_price) ?? _price;
  double? get priceBeforeDiscount => offer == null ? null : _price;

  @override
  FavoriteType get favoriteType => switch (this) {
    PlateEntity() => FavoriteType.plate,
    ProductEntity() => FavoriteType.product,
    OrderedWithEntity() => FavoriteType.plate,
    // _ => FavoriteType.unknown,
  };
  const GenericItemEntity({
    required super.id,
    required super.name,
    required super.image,
    required super.description,
    required super.rate,
    required double price,
    required this.reviewCount,
    required this.outOfStock,
    this.badge,
    this.tags,
    this.offer,
  }) : _price = price;

  @override
  List<Object?> get props => [
    ...super.props,
    _price,
    reviewCount,
    outOfStock,
    badge,
    tags,
    offer,
  ];
}
