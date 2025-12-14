import 'dart:ui';

import 'package:gazzer/core/domain/entities/favorable_interface.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/data/unit_brand_dto.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

part 'package:gazzer/features/vendors/resturants/domain/enities/ordered_with_entityy.dart';
part 'package:gazzer/features/vendors/resturants/domain/enities/plate_entity.dart';
part 'package:gazzer/features/vendors/stores/domain/entities/product_entity.dart';

/// generic class for both [PlateEntity] for restaurants and [ProductEntity] for stores or [OrderedWithEntity] for ordered with
sealed class GenericItemEntity extends Favorable {
  final double _price;
  final String? badge;
  final List<String>? tags;
  final OfferEntity? offer;
  final ItemUnitBrandEntity? itemUnitBrand;
  final SimpleStoreEntity? store;
  final int? orderCount;
  final int? sold;

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
    super.productId,
    required super.name,
    required super.image,
    required super.description,
    required super.rate,
    required super.outOfStock,
    required double price,
    required super.reviewCount,
    required super.hasOptions,
    this.badge,
    this.itemUnitBrand,
    this.store,
    this.tags,
    this.offer,
    this.orderCount,
    this.sold,
  }) : _price = price;

  @override
  List<Object?> get props => [...super.props, _price, badge, tags, offer, orderCount, hasOptions, sold];
}
