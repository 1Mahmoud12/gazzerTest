import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';


/// This file defines the Favorable interface which is implemented by entities that can be favorited.
/// 
/// [GenericVendorEntity] or [GenericItemEntity]
abstract class Favorable extends Equatable {
  final int id;
  final String name;
  final String description;
  final String image;
  final double rate;
  final double? favorablePrice;

  const Favorable({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.rate,
    this.favorablePrice,
  });

  @override
  List<Object?> get props => [id, name, description, image, rate, favorablePrice];

  FavoriteType get favoriteType;
}
