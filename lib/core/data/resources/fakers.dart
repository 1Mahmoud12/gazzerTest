import 'dart:math';

import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/profile/data/models/delete_account_reason_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';

/// A class that provides fake data for developing and for showing [Skeletonizer] widgets while loading real data.
class Fakers {
  Fakers._();
  static final _random = Random();

  static const placeHolderImg = "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png";
  static const plateNetWorkImg =
      "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=";

  static const netWorkImage =
      "https://cdni.iconscout.com/illustration/premium/thumb/female-user-image-illustration-download-in-svg-png-gif-file-formats--person-girl-business-pack-illustrations-6515859.png?f=webp";
  static final netWorkPRoductImage =
      "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=";

  static const _catsImages = [
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
    "https://gazzer-dev-do.mostafa.cloud/defaults/default_image.png",
  ];

  ///
  ///
  ///
  ///
  /// General
  static const addresses = [
    AddressEntity(
      id: 0,
      provinceId: 1,
      provinceName: 'provinceName',
      zoneId: 1,
      zoneName: 'zoneName',
      label: 'label',
      lat: 0.0,
      lng: 0.0,
      isDefault: true,
      floor: '1',
      apartment: '2',
      building: 'building',
    ),
    AddressEntity(
      id: 0,
      provinceId: 1,
      provinceName: 'provinceName',
      zoneId: 1,
      zoneName: 'zoneName',
      label: 'label',
      lat: 0.0,
      lng: 0.0,
      isDefault: false,
      floor: '1',
      apartment: '2',
      building: 'building',
    ),
  ];
  static final reasons = List.generate(
    5,
    (index) => DeleteAccountReasonDTO(
      title: 'asd  asd sad a dads',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing elit  lorem ipsum dolor sit amet, consectetur adipiscing elit  ',

      id: index,
    ),
  );

  static final fakeCats = List.generate(
    12,
    (index) => MainCategoryEntity(
      id: index,
      name: "فئة $index",
      image: _catsImages[_random.nextInt(_catsImages.length)],
      type: VendorType.restaurant,
    ),
  );
  static const mainCategory = MainCategoryEntity(
    id: 0,
    name: "فئة 0",
    image: placeHolderImg,
    type: VendorType.restaurant,
  );
  static const banners = [
    BannerEntity(
      id: 1,
      image: netWorkImage,
      title: "خصم 20% على جميع الطلبات",
      type: BannerType.image,
    ),
  ];

  ///
  ///
  ///
  ///
  ///
  /// retaurants\
  static const categoryOfPlate = CategoryOfPlateEntity(
    id: 0,
    name: "فئة 0",
    image: placeHolderImg,
    parentId: 0,
    style: CardStyle.typeOne,
    layout: LayoutType.grid,
  );
  static const categoriesOfPlate = [
    CategoryOfPlateEntity(
      id: 0,
      name: "فئة 0",
      image: placeHolderImg,
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
    CategoryOfPlateEntity(
      id: 1,
      name: "فئة 1",
      image: placeHolderImg,
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
    CategoryOfPlateEntity(
      id: 2,
      name: "فئة 2",
      image: placeHolderImg,
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
  ];
  static const restaurant = RestaurantEntity(
    alwaysClosed: false,
    alwaysOpen: false,
    id: 1,
    name: "طبق ",
    rate: 3,
    image:
        "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
    categoryOfPlate: categoriesOfPlate,
    address: 'ZAMALEK',
    deliveryFees: 123,
    badge: '30%',
    priceRange: '',
    tag: ['Free delivery'],
    location: 'ZAMALEK',
    subCategories: [
      CategoryOfPlateEntity(id: 1, name: 'Crepe', image: ''),
      CategoryOfPlateEntity(id: 2, name: 'Pizza', image: ''),
    ],
    startTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
    endTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
    parentId: 1,
    deliveryTime: '30-45 min',
    deliveryFee: 30.0,
    rateCount: 13,
    isFavorite: false,
    isOpen: true,
  );
  static final List<RestaurantEntity> restaurants = List.generate(
    8,
    (index) => const RestaurantEntity(
      alwaysClosed: false,
      alwaysOpen: false,
      id: 1,
      name: "طبق ",
      rate: 3,
      image:
          "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
      categoryOfPlate: categoriesOfPlate,
      address: 'ZAMALEK',
      deliveryFees: 123,
      badge: '30%',
      priceRange: '\$10 - \$20',
      tag: ['Free delivery'],
      location: 'ZAMALEK',
      subCategories: const [
        CategoryOfPlateEntity(id: 1, name: 'Crepe', image: ''),
        CategoryOfPlateEntity(id: 2, name: 'Pizza', image: ''),
      ],
      startTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      endTime: null, //DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
      parentId: 1,
      deliveryTime: '30-45 min',
      deliveryFee: 30.0,
      rateCount: 13,
      isFavorite: false,
      isOpen: true,
    ),
  );

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
      outOfStock: _random.nextBool(),
      badge: _random.nextBool() ? '30%' : null,
      reviewCount: _random.nextDouble().toInt() * 100,
    ),
  );
  static const plate = PlateEntity(
    id: 0,
    name: "طبق 1",
    description: "وصف الطبق 1",
    price: 12,
    rate: 4,
    image:
        "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
    categoryPlateId: 0,
    outOfStock: false,
    badge: '30%',
    reviewCount: 12,
  );
  static final plateOrderedWith = List.generate(
    3,
    (index) => OrderedWithEntity(id: index, name: 'Item index', image: Fakers.netWorkImage, price: 0, rate: 3, reviewCount: 0, outOfStock: false),
  );
  static final plateOptions = List.generate(
    3,
    (index) => ItemOptionEntity(
      id: index,
      name: 'Option ${index + 1}',
      isRequired: _random.nextBool(),
      type: OptionType.radio,
      controlsPrice: _random.nextBool(),
      values: List.generate(
        3,
        (valueIndex) => OpionValueEntity(
          id: valueIndex,
          name: 'Value ${valueIndex + 1}',
          price: _random.nextDouble() * 10,
          isDefault: valueIndex == 0, // First value is default
        ),
      ),
    ),
  );

  ///
  ///
  ///
  ///
  ///
  /// stores
  static const List<StoreEntity> stores = [
    StoreEntity(
      alwaysClosed: false,
      alwaysOpen: false,
      id: 0,
      name: "طبق ",
      rate: 3,
      image: plateNetWorkImg,
      tag: ['Free delivery'],
      location: 'ZAMALEK',
      startTime: null,
      endTime: null,
      parentId: 1,
      isFavorite: false,
      isOpen: true,
    ),
    StoreEntity(
      alwaysClosed: false,
      alwaysOpen: false,
      id: 0,
      name: "طبق ",
      rate: 3,
      image: plateNetWorkImg,
      tag: ['Free delivery'],
      location: 'ZAMALEK',
      startTime: null,
      endTime: null,
      parentId: 1,
      isFavorite: false,
      isOpen: true,
    ),
  ];
  static const store = StoreEntity(
    alwaysClosed: false,
    alwaysOpen: false,
    id: 0,
    name: "طبق ",
    rate: 3,
    image: plateNetWorkImg,
    tag: ['Free delivery'],
    location: 'ZAMALEK',
    startTime: null,
    endTime: null,
    parentId: 1,
    isFavorite: false,
    isOpen: true,
  );
  static const fakeProds = [
    ProductEntity(
      id: 0,
      name: "منتج ",
      description: "وصف ",
      price: 0,
      rate: 3.1,
      image: Fakers.netWorkImage,
      outOfStock: false,
      reviewCount: 100,
    ),
    ProductEntity(
      id: 0,
      name: "منتج ",
      description: "وصف ",
      price: 0,
      rate: 3.1,
      image: Fakers.netWorkImage,
      outOfStock: false,
      reviewCount: 100,
    ),
  ];
  static const storeCat = StoreCategoryEntity(
    id: 0,
    name: "فئة المتجر",
    image: placeHolderImg,
    parentId: 0,
    style: CardStyle.typeOne,
    layout: LayoutType.grid,
  );
  static final storeCats = List.generate(
    5,
    (index) => StoreCategoryEntity(
      id: index,
      name: "فئة المتجر ${index + 1}",
      image: placeHolderImg,
      parentId: 0,
      style: CardStyle.typeOne,
      layout: LayoutType.grid,
    ),
  );

  /// favorties
  static const favorite = ProductEntity(
    id: 1,
    name: "المفضل ",
    description: "وصف المفضل ",
    image: placeHolderImg,
    rate: 5,
    price: 100,
    outOfStock: false,
    reviewCount: 50,
  );
  static const favorites = {
    0: favorite,
    1: favorite,
    2: favorite,
    3: favorite,
    4: favorite,
  };

  ///
  ///
  static final cartResponse = CartResponse(
    addressId: null,
    subTotal: 0.0,
    deliveryFee: 0.0,
    serviceFee: 0.0,
    discount: 0.0,
    total: 0.0,
    vendors: [],
  );
}
