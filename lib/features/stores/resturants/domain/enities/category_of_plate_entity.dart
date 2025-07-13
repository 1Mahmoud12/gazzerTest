class CategoryOfPlateEntity {
  final int id;
  final String name;
  final String image;
  final CategoryStyle style;

  CategoryOfPlateEntity(this.id, this.name, this.image, this.style);
}

enum CategoryStyle {
  horizontalScrollHorzCard,
  horizontalScrollVertCard,
  verticalGrid,
  horizontalScrollHorzCardCorner,
  verticalScrollHorzCard,
}
