import 'package:gazzer/features/stores/resturants/domain/enities/plate_entity.dart';

class PlateDTO {
  int? id;
  int? storeId;
  String? plateName;
  int? plateCategoryId;
  int? toBeDisplayedOnApp;
  int? toBeDisplayedOnStore;
  int? parentRestaurantPlateId;
  String? plateDescription;
  String? otherVariant;
  String? addons;
  String? size;
  String? price;
  int? priceUnitId;
  String? appPrice;
  String? createdAt;
  String? updatedAt;

  PlateDTO({
    this.id,
    this.storeId,
    this.plateName,
    this.plateCategoryId,
    this.toBeDisplayedOnApp,
    this.toBeDisplayedOnStore,
    this.parentRestaurantPlateId,
    this.plateDescription,
    this.otherVariant,
    this.addons,
    this.size,
    this.price,
    this.priceUnitId,
    this.appPrice,
    this.createdAt,
    this.updatedAt,
  });

  PlateDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    plateName = json['plate_name'];
    plateCategoryId = json['plate_category_id'];
    toBeDisplayedOnApp = json['to_be_displayed_on_app'];
    toBeDisplayedOnStore = json['to_be_displayed_on_store'];
    parentRestaurantPlateId = json['parent_restaurant_plate_id'];
    plateDescription = json['plate_description'];
    otherVariant = json['OtherVariant'];
    addons = json['addons'];
    size = json['size'];
    price = json['price'];
    priceUnitId = json['price_unit_id'];
    appPrice = json['app_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  PlateEntity toPlateEntity() {
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
