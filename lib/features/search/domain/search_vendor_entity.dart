import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/search/domain/search_product_entity.dart';

class SearchVendorEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final String zoneName;
  final double rate;
  final int rateCount;
  final String? deliveryTime;
  final VendorType type;
  final List<String>? tags;
  final List<SearchProductEntity> items;

  const SearchVendorEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.zoneName,
    required this.rate,
    required this.rateCount,
    this.deliveryTime,
    this.tags,
    required this.items,
    required this.type,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    zoneName,
    rate,
    rateCount,
    deliveryTime,
    tags,
    type,
    image,
    items,
  ];
}
