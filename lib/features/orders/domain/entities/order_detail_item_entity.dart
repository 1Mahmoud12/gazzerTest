class OrderDetailItemEntity {
  final int id;
  final String name;
  final String image;
  final int quantity;
  final double price;
  final List<String> addOns; // e.g., ["2 V Cola"]

  const OrderDetailItemEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    this.addOns = const [],
  });
}
