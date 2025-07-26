import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/category_of_plate_dto.dart';

class RestaurantDTO {
  int? id;
  String? storeName;
  int? vendorId;
  String? location;
  String? weightDeviationPercent;
  // int? trackingOnPackingAndPickup;
  String? address;
  // String? contactPerson;
  // int? staringCashNeedsSupervisorApproval;
  int? isRestaurant;
  // int? autoHideItemOnThreshold;
  int? isActive;
  String? timeForEditingOrder;
  // int? autoApproveUpdatesOnOrderDivision;
  int? countryZoneId;
  int? storeCategoryId;
  List<CategoryOfPlateDTO>? subcategories;

  RestaurantDTO({
    this.id,
    this.storeName,
    this.vendorId,
    this.location,
    this.weightDeviationPercent,
    // this.trackingOnPackingAndPickup,
    this.address,
    // this.contactPerson,
    // this.staringCashNeedsSupervisorApproval,
    this.isRestaurant,
    // this.autoHideItemOnThreshold,
    this.isActive,
    this.timeForEditingOrder,
    // this.autoApproveUpdatesOnOrderDivision,
    this.countryZoneId,
    this.storeCategoryId,
    this.subcategories,
  });

  RestaurantDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    vendorId = json['vendor_id'];
    location = json['location'];
    weightDeviationPercent = json['weight_deviation_percent'];
    // trackingOnPackingAndPickup = json['tracking_on_packing_and_pickup'];
    address = json['address'];
    // contactPerson = json['contact_person'];
    // staringCashNeedsSupervisorApproval = json['staring_cash_needs_supervisor_approval'];
    isRestaurant = json['is_restaurant'];
    // autoHideItemOnThreshold = json['auto_hide_item_on_threshold'];
    isActive = json['is_active'];
    timeForEditingOrder = json['time_for_editing_order'];
    // autoApproveUpdatesOnOrderDivision = json['auto_approve_updates_on_order_division'];
    countryZoneId = json['country_zone_id'];
    storeCategoryId = json['store_category_id'];
    if (json['subcategories'] != null) {
      subcategories = <CategoryOfPlateDTO>[];
      json['subcategories'].forEach((v) {
        subcategories!.add(CategoryOfPlateDTO.fromJson(v));
      });
    }
  }

  RestaurantEntity toRestEntity() {
    return RestaurantEntity(
      id: id!,
      name: storeName!,
      image:
          "https://media.istockphoto.com/id/1293479617/photo/woman-hands-eating-vegan-salad-of-baked-vegetables-avocado-tofu-and-buckwheat-buddha-bowl-top.jpg?s=612x612&w=0&k=20&c=jATx1jeDBsUgT2zIla6eh-i1OUPvIfgkb0-4QnAruAY=",
      rate: 0,
      estimateDeliveryTime: '',
      deliveryFees: null,
      promotionalMessage: null,
      location: location ?? 'ZAMALEK',
      address: address,
      parentId: storeCategoryId,

      reviewCount: 0,
      categoryOfPlate: subcategories?.map((e) => e.toCategoryOfPlateEntity()).toList(),
      description: '',
      isClosed: id?.isEven ?? false,
      badge: '30%',
      priceRange: '\$10 - \$20',
      tag: null,
      startTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0),
      endTime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 0),
      subCategories: subcategories
          ?.map((e) => GenericSubCategoryEntity(id: e.id!, name: e.name ?? '', image: e.image))
          .toList(),
      deliveryTime: '30-45 min',
      deliveryFee: 30.0,
      rateCount: 13,
    );
  }
}
