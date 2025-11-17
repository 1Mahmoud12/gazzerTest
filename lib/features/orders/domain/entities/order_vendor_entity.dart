class OrderVendorEntity {
  final int id;
  final String name;
  final String? image;
  final String? logo;

  const OrderVendorEntity({
    required this.id,
    required this.name,
    this.image,
    this.logo,
  });
}
