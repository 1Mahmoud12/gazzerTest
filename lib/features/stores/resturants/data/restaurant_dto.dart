import 'package:gazzer/features/stores/resturants/data/category_of_plate_dto.dart';
import 'package:gazzer/features/stores/resturants/domain/restaurant_entity.dart';

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

  RestaurantEntity toStorEntity() {
    return RestaurantEntity(
      id: id!,
      name: storeName!,
      logo: "logo",
      rate: null,
      estimateDeliveryTime: null,
      deliveryFees: null,
      promotionalMessage: null,
      location: location,
      address: address,
      isRestaurant: isRestaurant,
      storeCategoryId: storeCategoryId,
      subcategories: subcategories?.map((e) => e.toSubCategoryEntity()).toList(),
    );
  }
}
