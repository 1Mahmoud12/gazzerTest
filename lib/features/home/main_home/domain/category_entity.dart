enum CategoryType {
  restaurant('Restaurant'),
  grocery('Grocery'),
  pharmacy('Pharmacy');

  final String value;

  const CategoryType(this.value);

  static CategoryType fromString(String value) {
    return CategoryType.values.firstWhere((type) => type.value == value, orElse: () => CategoryType.restaurant);
  }
}

class MainCategoryEntity {
  final int id;
  final String name;
  final String image;
  final CategoryType type;

  const MainCategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });
}
