class ProductModel {
  final int id;
  final String name;
  final String description;
  final double price;
  final double rate;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rate,
    required this.image,
  });

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, price: $price, rate: $rate, imageUrl: $image)';
  }
}
