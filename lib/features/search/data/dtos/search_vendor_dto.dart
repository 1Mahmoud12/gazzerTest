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
  List<String>? tags;

  /// missing
  // zone

  SearchVendorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeName = json['store_name'];
    image = json['image'];
    estimatedDeliveryTime = json['estimated_delivery_time'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    isRestaurant = json['is_restaurant'];
    // products
    if (json['items'] != null) {
      products = (json['items'] as List).map((e) => SearchProductDTO.fromJson(e, ItemType.product)).toList();
    }
    //plates
    if (json['plates'] != null) {
      products = (json['plates'] as List).map((e) => SearchProductDTO.fromJson(e, ItemType.plate)).toList();
    }
    if (json['tags'] is List) {
      tags = [];
      for (final e in json['tags']) {
        tags!.add(e['name']);
      }
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
      type: isRestaurant == 1 ? VendorType.restaurant : VendorType.grocery,
      items: products?.map((e) => e.toEntity()).toList() ?? [],
      tags: tags,

      zoneName: '**blank**', //TODO replace with real data
    );
  }
}
