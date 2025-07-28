import 'dart:math';

import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/profile/data/models/delete_account_reason_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/category_add_model.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/category_of_plate_entity.dart';

/// A class that provides fake data for developing and for showing [Skeletonizer] widgets while loading real data.
class Fakers {
  Fakers._();
  static final _random = Random();
  static final fakeProds = List.generate(
    10,
    (index) => PlateEntity(
      id: index,
      name: "منتج $index",
      description: "وصف $index",
      price: _random.nextDouble() * 100,
      rate: _random.nextDouble() * 5,
      image:
          "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
      categoryPlateId: _random.nextInt(5),
      options: [],
      priceBeforeDiscount: _random.nextDouble() * 110,
      outOfStock: _random.nextBool(),
      badge: _random.nextBool() ? '30%' : null,
      reviewCount: _random.nextDouble() * 100,
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
  static const categoryOfPlate = CategoryOfPlateEntity(
    id: 0,
    name: "فئة 0",
    image: "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    parentId: 0,
    style: CardStyle.typeOne,
    layout: LayoutType.grid,
  );
  static const categoriesOfPlateentity = [
    CategoryOfPlateEntity(
      id: 0,
      name: "فئة 0",
      image: "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
    CategoryOfPlateEntity(
      id: 1,
      name: "فئة 1",
      image: "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
    CategoryOfPlateEntity(
      id: 2,
      name: "فئة 2",
      image: "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
  ];

  static const banners = [
    BannerEntity(
      id: 1,
      image: "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
      title: "خصم 20% على جميع الطلبات",
      type: BannerType.image,
    ),
  ];

  static final netWorkImage =
      "https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp";
  static final netWorkPRoductImage =
      "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=";

  static final _catsImages = const [
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
  ];

  ///
  static final List<PlateEntity> plates = List.generate(
    8,
    (index) => PlateEntity(
      id: index,
      name: "طبق ${index + 1}",
      description: "وصف الطبق ${index + 1}",
      price: _random.nextDouble() * 100,
      rate: _random.nextDouble() * 5,
      image:
          "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
      categoryPlateId: 0,
      options: [],
      priceBeforeDiscount: _random.nextDouble() * 110,
      outOfStock: _random.nextBool(),
      badge: _random.nextBool() ? '30%' : null,
      reviewCount: _random.nextDouble() * 100,
    ),
  );

  ///

  static const restaurant = RestaurantEntity(
    id: 1,
    name: "طبق ",
    rate: 3,
    image:
        "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
    reviewCount: 25,
    categoryOfPlate: categoriesOfPlateentity,
    address: 'ZAMALEK',
    deliveryFees: 123,
    badge: '30%',
    priceRange: '\$10 - \$20',
    tag: ['Free delivery'],
    location: 'ZAMALEK',
    subCategories: [
      GenericSubCategoryEntity(id: 1, name: 'Crepe', image: ''),
      GenericSubCategoryEntity(id: 2, name: 'Pizza', image: ''),
    ],
    startTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
    endTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
    parentId: 1,
    deliveryTime: '30-45 min',
    deliveryFee: 30.0,
    rateCount: 13,
  );
  static final List<RestaurantEntity> restaurants = List.generate(
    8,
    (index) => const RestaurantEntity(
      id: 1,
      name: "طبق ",
      rate: 3,
      image:
          "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
      reviewCount: 25,
      categoryOfPlate: categoriesOfPlateentity,
      address: 'ZAMALEK',
      deliveryFees: 123,
      badge: '30%',
      priceRange: '\$10 - \$20',
      tag: ['Free delivery'],
      location: 'ZAMALEK',
      subCategories: const [
        GenericSubCategoryEntity(id: 1, name: 'Crepe', image: ''),
        GenericSubCategoryEntity(id: 2, name: 'Pizza', image: ''),
      ],
      startTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      endTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
      parentId: 1,
      deliveryTime: '30-45 min',
      deliveryFee: 30.0,
      rateCount: 13,
    ),
  );

  ///
  static final List<StoreEntity> stores = List.generate(
    8,
    (index) => StoreEntity(
      id: index,
      name: "طبق ${index + 1}",
      rate: _random.nextDouble() * 5,
      image:
          "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
      reviewCount: _random.nextInt(100),
      estimateDeliveryTime: "${_random.nextInt(20)} - ${_random.nextInt(20) + 20} دقيقة",
      address: 'ZAMALEK',
      deliveryFees: 123,
      isRestaurant: true,
      badge: '30%',
      priceRange: '\$10 - \$20',
      tag: ['Free delivery'],
      location: 'ZAMALEK',
      subCategories: const [
        GenericSubCategoryEntity(id: 1, name: 'Crepe', image: ''),
        GenericSubCategoryEntity(id: 2, name: 'Pizza', image: ''),
      ],
      startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
      parentId: index % 3 == 0 ? null : index - 1, // Random parent ID for testing
      deliveryTime: '30-45 min',
      deliveryFee: 30.0,
      rateCount: 13,
    ),
  );

  ///
  static final addresses = List.generate(
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
      apartment: _random.nextInt(100),
      building: "مبنى ${index + 1}",
      description: "وصف العنوان ${index + 1}",
      landmark: "معلم ${index + 1}",
      zoneName: "منطقة ${index + 1}",
      provinceName: "محافظة ${index + 1}",
    ),
  );

  static final reasons = List.generate(
    5,
    (index) => DeleteAccountReasonDTO(
      title: 'asd  asd sad a dads',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit  lorem ipsum dolor sit amet, consectetur adipiscing elit  ',

      id: index,
    ),
  );
}
