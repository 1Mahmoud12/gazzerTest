import 'package:gazzer/core/presentation/extensions/enum.dart';

class MainCategoryEntity {
  final int id;
  final String name;
  final String image;
  final VendorType type;

  const MainCategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
  });
}
