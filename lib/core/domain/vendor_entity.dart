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
