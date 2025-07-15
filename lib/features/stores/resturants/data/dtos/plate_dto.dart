import 'package:gazzer/features/stores/domain/store_item_entity.dart.dart';

sealed class StoreItemDTO {
  StoreItemDTO();
  StoreItemDTO.fromJson(Map<String, dynamic> json);
  ProductItemEntity toProductItem();
}

class PlateDTO extends StoreItemDTO {
  int? id;
  int? storeId;
  String? plateName;
  int? plateCategoryId;
  String? plateDescription;
  String? otherVariant;
  String? addons;
  String? size;
  double? price;
  double? rate;
  double? appPrice;

  PlateDTO({
    this.id,
    this.storeId,
    this.plateName,
    this.plateCategoryId,
    this.plateDescription,
    this.otherVariant,
    this.addons,
    this.size,
    this.price,
    this.rate,
    this.appPrice,
  });

  PlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    plateName = json['plate_name'];
    plateCategoryId = json['plate_category_id'];
    plateDescription = json['plate_description'];
    otherVariant = json['OtherVariant'];
    addons = json['addons'];
    size = json['size'];
    price = double.tryParse(json['price'].toString());
    rate = double.tryParse(json['rate'].toString());
    appPrice = double.tryParse(json['app_price'].toString());
  }

  @override
  ProductItemEntity toProductItem() {
    return PlateEntity(
      id: id!,
      categoryPlateId: plateCategoryId ?? 0,
      name: plateName ?? '',
      description: plateDescription ?? '',
      image:
          'https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=',
      price: double.tryParse(price.toString()) ?? 0,
      rate: 0.0,
      priceBeforeDiscount: 0,
      options: [],
    );
  }
}

class ProductDTO extends StoreItemDTO {
  int? id;
  int? storeId;
  String? plateName;
  int? plateCategoryId;
  String? plateDescription;
  String? otherVariant;
  String? addons;
  String? size;
  String? price;
  String? rate;
  String? appPrice;

  ProductDTO({
    this.id,
    this.storeId,
    this.plateName,
    this.plateCategoryId,
    this.plateDescription,
    this.otherVariant,
    this.addons,
    this.size,
    this.price,
    this.rate,
    this.appPrice,
  });

  ProductDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    plateName = json['plate_name'];
    plateCategoryId = json['plate_category_id'];
    plateDescription = json['plate_description'];
    otherVariant = json['OtherVariant'];
    addons = json['addons'];
    size = json['size'];
    price = json['price'];
    rate = json['rate'];
    appPrice = json['app_price'];
  }

  @override
  ProductItemEntity toProductItem() {
    return ProductEntity(
      id: id!,
      name: plateName ?? '',
      description: plateDescription ?? '',
      price: double.tryParse(price.toString()) ?? 0,
      storeId: storeId,
    );
  }
}
