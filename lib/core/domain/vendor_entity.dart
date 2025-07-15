class VendorEntity {
  final int id;
  final String vendorName;
  final String? contactPerson;
  final String? secondContactPerson;
  VendorEntity({
    required this.id,
    required this.vendorName,
    this.contactPerson,
    this.secondContactPerson,
  });
}
