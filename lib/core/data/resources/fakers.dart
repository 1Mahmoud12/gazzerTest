import 'dart:math';

import 'package:gazzer/core/domain/cart/cart_item_model.dart';
import 'package:gazzer/core/domain/cart/vendor_products_model.dart';
import 'package:gazzer/core/domain/cusine/cuisine_model.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/profile/domain/address_entity.dart';
import 'package:gazzer/features/stores/resturants/data/category_add_model.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/category_of_plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/plate_entity.dart';
import 'package:gazzer/features/stores/resturants/domain/enities/restaurant_entity.dart';

/// A class that provides fake data for developing and for showing [Skeletonizer] widgets while loading real data.
class Fakers {
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
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
  ];

  static final _random = Random();
  static final fakeProds = List.generate(
    10,
    (index) => ProductModel(
      id: index,
      name: "منتج $index",
      description: "وصف $index",
      price: _random.nextDouble() * 100,
      rate: _random.nextDouble() * 5,
      image: _prodImages[_random.nextInt(_prodImages.length)],
    ),
  );

  static final fakeCats = List.generate(
    12,
    (index) => CategoryEntity(
      index,
      "فئة $index",
      _catsImages[_random.nextInt(_catsImages.length)],
      CategoryType.restaurant,
    ),
  );

  static final fakeCuisines = List.generate(
    8,
    (index) => CuisineModel(id: index, name: "مطبخ $index", image: _prodImages[_random.nextInt(_prodImages.length)]),
  );
  static final fakecartItems = List.generate(
    5,
    (index) => CartItemModel.fromProduct(fakeProds[_random.nextInt(fakeProds.length)]),
  );
  static final fakeVendors = List.generate(
    3,
    (index) => VendorProductsModel(
      id: index,
      vendorName: "بائع ${index + 1}",
      vendorImage: _prodImages[_random.nextInt(_prodImages.length)],
      cartItems: List.generate(5, (index) {
        return fakecartItems[index];
      }),
    ),
  );
  static final restCatAdds = List.generate(
    4,
    (index) => CategoryAddModel(
      id: index,
      title: "خصم من برجر الدجاج",
      image: Assets.assetsPngSandwitch,
      discountPercentage: _random.nextDouble() * 100,
      dataId: _random.nextInt(4),
      type: "طعام",
    ),
  );
  static final fakeSubCats = List.generate(
    10,
    (index) => CategoryOfPlateEntity(
      index,
      "فئة فرعية ${index + 1}",
      _catsImages[_random.nextInt(_catsImages.length)],
      CategoryStyle.values[_random.nextInt(CategoryStyle.values.length)],
    ),
  );

  static final vendors = List.generate(
    4,
    (index) => RestaurantEntity(
      id: index,
      name: "بائع ${index + 1}",
      image: _prodImages[_random.nextInt(_prodImages.length)],
      rate: _random.nextDouble() * 5,
      reviewCount: _random.nextInt(100),
      estimateDeliveryTime: "${_random.nextInt(20)} - ${_random.nextInt(20) + 20} دقيقة",
      categoryOfPlate: fakeSubCats,
    ),
  );

  final List<PlateEntity> plates = List.generate(
    8,
    (index) => PlateEntity(
      id: index,
      name: "طبق ${index + 1}",
      description: "وصف الطبق ${index + 1}",
      price: _random.nextDouble() * 100,
      rate: _random.nextDouble() * 5,
      image: _prodImages[_random.nextInt(_prodImages.length)],
      categoryPlateId: 0,
      options: [],
      priceBeforeDiscount: _random.nextDouble() * 110,
    ),
  );
  final List<RestaurantEntity> restaurants = List.generate(
    8,
    (index) => RestaurantEntity(
      id: index,
      name: "طبق ${index + 1}",
      rate: _random.nextDouble() * 5,
      image: _prodImages[_random.nextInt(_prodImages.length)],
      reviewCount: _random.nextInt(100),
      estimateDeliveryTime: "${_random.nextInt(20)} - ${_random.nextInt(20) + 20} دقيقة",
      categoryOfPlate: fakeSubCats,
      address: 'asd asd ad',
      deliveryFees: 123,
      isRestaurant: true,
    ),
  );

  final addresses = List.generate(
    3,
    (index) => AddressEntity(
      id: index,
      street: "شارع ${index + 1}",
      provinceId: _random.nextInt(10),
      zoneId: _random.nextInt(10),
      label: index == 0
          ? 'home'
          : index == 1
          ? 'work'
          : 'other',
      lat: 0.0,
      lng: 0.0,
      isDefault: index == 0, // First address is default
      floor: _random.nextInt(5),
      apartmentNum: _random.nextInt(100),
      description: "وصف العنوان ${index + 1}",
      landmark: "معلم ${index + 1}",
    ),
  );
}
