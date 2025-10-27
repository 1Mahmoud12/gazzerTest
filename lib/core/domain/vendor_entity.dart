import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

/// this class should be removed adn replaced by [GenericVendorEntity]

class VendorEntity {
  final int id;
  final String name;
  final int storeId;
  final String? contactPerson;
  final String? secondContactPerson;
  final String? type;
  final int? totalOrders;

  /// not given by api yet;
  final String image;
  VendorEntity({
    required this.id,
    required this.name,
    required this.storeId,
    this.contactPerson,
    this.secondContactPerson,
    this.type,
    this.totalOrders,
    required this.image,
  });
}
