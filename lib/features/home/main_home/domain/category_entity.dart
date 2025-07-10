enum CategoryType {
  restaurant('restaurant'),
  grocery('grocery'),
  pharmacy('pharmacy');

  final String value;

  const CategoryType(this.value);

  static CategoryType fromString(String value) {
    return CategoryType.values.firstWhere((type) => type.value == value, orElse: () => CategoryType.restaurant);
  }
}

class CategoryEntity {
  final int id;
  final String name;
  final String image;
  final CategoryType type;

  CategoryEntity(this.id, this.name, this.image, this.type);
}
