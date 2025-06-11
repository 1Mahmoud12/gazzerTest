import 'dart:math';

import 'package:gazzer/core/domain/cart/cart_item_model.dart';
import 'package:gazzer/core/domain/cart/vendor_products_model.dart';
import 'package:gazzer/core/domain/category/category_model.dart';
import 'package:gazzer/core/domain/cusine/cuisine_model.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/features/resturants/resturants_category/data/category_add_model.dart';
import 'package:gazzer/features/resturants/resturants_category/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/resturants_category/data/vendor_model.dart';

class Fakers {
  Fakers._();

  static final _prodImages = [
    Assets.assetsPngFastFood,
    Assets.assetsPngFood2,
    Assets.assetsPngFood3,
    Assets.assetsPngFood4,
    Assets.assetsPngFood5,
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
  static final fakecartItems = List.generate(
    5,
    (index) => CartItemModel.fromProduct(fakeProds[_random.nextInt(fakeProds.length)]),
  );
  static final fakeVendors = List.generate(
    3,
    (index) => VendorProductsModel(
      id: index,
      vendorName: "Vendor ${index + 1}",
      vendorImage: _catsImages[_random.nextInt(_catsImages.length)],
      cartItems: List.generate(5, (index) {
        return fakecartItems[index];
      }),
    ),
  );
  static final restCatAdds = List.generate(
    4,
    (index) => CategoryAddModel(
      id: index,
      title: "Off From Checken Burder",
      image: Assets.assetsPngSandwitch,
      discountPercentage: _random.nextDouble() * 100,
      dataId: _random.nextInt(4),
      type: "food",
    ),
  );
  static final fakeSubCats = List.generate(
    6,
    (index) => SubcategoryModel(
      id: index,
      name: "Subcategory ${index + 1}",
      imageUrl: _catsImages[_random.nextInt(_catsImages.length)],
    ),
  );

  static final vendors = List.generate(
    4,
    (index) => VendorModel(
      id: index,
      name: "Vendor ${index + 1}",
      imageUrl: _catsImages[_random.nextInt(_catsImages.length)],
      rate: _random.nextDouble() * 5,
      reviewCount: _random.nextInt(100),
      deliveryTime: "${_random.nextInt(20)} - ${_random.nextInt(20) + 20} min",
      items: List.generate(_random.nextInt(_prodImages.length - 1) + 1, (index) => _prodImages[index]),
    ),
  );
}
