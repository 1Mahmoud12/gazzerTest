import 'dart:math';

import 'package:gazzer/core/domain/category/category_model.dart';
import 'package:gazzer/core/domain/cusine/cuisine_model.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';

class Fakers {
  Fakers._();

  static final _prodImages = [
    Assets.assetsPngFastFood,
    Assets.assetsPngFood2,
    Assets.assetsPngFood3,
    Assets.assetsPngFood4,
    Assets.assetsPngFood5,
  ];

  static final _catsImages = [
    Assets.assetsPngFastFood,
    Assets.assetsPngGrocery,
    Assets.assetsPngBakery,
    Assets.assetsPngMedic,
  ];

  static final _random = Random();
  static final fakeProds = List.generate(
    10,
    (index) => ProductModel(
      id: index,
      name: "Product $index",
      description: "Description $index",
      price: _random.nextDouble() * 100,
      rate: _random.nextDouble() * 5,
      image: _prodImages[_random.nextInt(_prodImages.length)],
    ),
  );

  static final fakeCats = List.generate(
    12,
    (index) =>
        CategoryModel(id: index, name: "Category $index", image: _catsImages[_random.nextInt(_catsImages.length)]),
  );

  static final fakeCuisines = List.generate(
    8,
    (index) => CuisineModel(id: index, name: "Cuisine $index", image: _catsImages[_random.nextInt(_catsImages.length)]),
  );
}
