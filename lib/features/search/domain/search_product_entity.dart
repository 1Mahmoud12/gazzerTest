import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

class SearchProductEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String? badge;
  final double _price;
  final double rate;
  final ItemType type;
  final OfferEntity? offer;
  double get price => offer?.priceAfterDiscount(_price) ?? _price;

  const SearchProductEntity({
    required this.id,
    required this.name,
    required this.image,
    this.badge,
    required double price,
    required this.rate,
    required this.type,
    this.offer,
  }) : _price = price;

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    badge,
    price,
    rate,
    type,
    offer,
  ];
}
