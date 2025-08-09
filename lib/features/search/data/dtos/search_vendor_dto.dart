import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/search/data/dtos/search_product_dto.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';

class SearchVendorDTO {
  int? id;
  String? storeName;
  String? image;
  int? estimatedDeliveryTime;
  String? rate;
  int? rateCount;
  int? isRestaurant;
  List<SearchProductDTO>? products;

  /// missing
  // zoone
  // tags

  SearchVendorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    image = json['image'];
    estimatedDeliveryTime = json['estimated_delivery_time'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    isRestaurant = json['is_restaurant'];
    if (json['items'] != null) {
      products = (json['items'] as List).map((e) => SearchProductDTO.fromJson(e)).toList();
    }
  }

  SearchVendorEntity toEntity() {
    return SearchVendorEntity(
      id: id!,
      name: storeName!,
      image: image!,
      deliveryTime: estimatedDeliveryTime?.toString(),
      rate: double.tryParse(rate.toString()) ?? 0,
      rateCount: rateCount ?? 0,
      items: products?.map((e) => e.toEntity()).toList() ?? [],
      type: isRestaurant == 1 ? VendorType.restaurant : VendorType.grocery,
      zoneName: '',
      tags: null,
    );
  }
}
