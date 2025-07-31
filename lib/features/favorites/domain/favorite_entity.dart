// import 'package:equatable/equatable.dart';
// import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
// import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

// export 'package:gazzer/core/presentation/extensions/enum.dart';

// class FavoriteEntity extends Equatable {
//   final int id;
//   final String name;
//   final String? description;
//   final String image;
//   final double rate;
//   final double? price;
//   final FavoriteType type; // e.g., 'restaurant', 'grocery', 'pharmacy'

//   const FavoriteEntity({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.type,
//     this.description,
//     this.rate = 0.0,
//     this.price,
//   });

//   @override
//   List<Object?> get props => [id, name, description, image, rate, price, type];

//   static FavoriteEntity fromItem(GenericItemEntity item) {
//     return FavoriteEntity(
//       id: item.id,
//       name: item.name,
//       image: item.image,
//       type: item is PlateEntity
//           ? FavoriteType.plate
//           : item is ProductEntity
//           ? FavoriteType.product
//           : FavoriteType.unknown,
//       description: item.description,
//       rate: item.rate,
//       price: item.price,
//     );
//   }

//   static FavoriteEntity fromVendor(GenericVendorEntity vendor) {
//     return FavoriteEntity(
//       id: vendor.id,
//       name: vendor.name,
//       image: vendor.image,
//       type: vendor is PlateEntity
//           ? FavoriteType.plate
//           : vendor is ProductEntity
//           ? FavoriteType.product
//           : FavoriteType.unknown,
//       description: vendor.tag?.join(', '),
//       rate: vendor.rate,
//     );
//   }
// }
