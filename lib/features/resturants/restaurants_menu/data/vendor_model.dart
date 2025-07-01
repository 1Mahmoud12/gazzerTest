class VendorModel {
  final int id;
  final String name;
  final String image;
  final double rate;
  final int reviewCount;
  final String deliveryTime;
  final List<String> items;
  final String description =
      "Vendor description data goes here. It can be a brief overview of the vendor's offerings, specialties, or any other relevant information that helps customers understand what to expect from this vendor.";

  VendorModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rate,
    required this.reviewCount,
    required this.deliveryTime,
    required this.items,
  });
}
