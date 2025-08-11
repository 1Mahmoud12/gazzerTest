import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

/// this class should be removed adn replaced by [GenericVendorEntity]

class VendorEntity {
  final int id;
  final String name;
  final String? contactPerson;
  final String? secondContactPerson;

  /// not given by api yet;
  final String image;
  VendorEntity({
    required this.id,
    required this.name,
    this.contactPerson,
    this.secondContactPerson,
    required this.image,
  });
}
