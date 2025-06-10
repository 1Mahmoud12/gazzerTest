class VendorModel {
  final int id;
  final String name;
  final String imageUrl;
  final double rate;
  final int reviewCount;
  final String deliveryTime;
  final List<String> items;

  VendorModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rate,
    required this.reviewCount,
    required this.deliveryTime,
    required this.items,
  });
}
