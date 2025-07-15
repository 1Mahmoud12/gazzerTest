import 'package:gazzer/features/home/main_home/data/banner_dto.dart';
import 'package:gazzer/features/home/main_home/data/product_item_dto.dart';

enum SectionType {
  categories('categories'),
  dailyOffers('daily_offers'),
  suggested('suggested'),
  topItems('top_items'),
  topVendors('top_vendors'),
  bestPopular('best_popular'),
  unknown('unknown');

  final String type;
  const SectionType(this.type);
  static SectionType fromString(String type) {
    return SectionType.values.firstWhere((e) => e.type == type, orElse: () => unknown);
  }
}

class SectionDTO {
  int? id;
  String? title;
  late final SectionType type;
  int? bannerId;
  int? isActive;
  BannerDTO? banner;
  List<ProductItemDTO>? data;

  SectionDTO({this.id, this.title, required this.type, this.bannerId, this.isActive, this.banner, this.data});

  SectionDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    type = SectionType.fromString(json['type']);
    bannerId = json['banner_id'];
    isActive = json['is_active'];
    banner = json['banner'] != null ? BannerDTO.fromJson(json['banner']) : null;
    data = [];
    if (type == SectionType.categories) {
      for (var item in json['data']) {
        data!.add(CategoryDTO.fromJson(item));
      }
    } else if (type == SectionType.topVendors) {
      for (var item in json['data']) {
        data!.add(VendorDTO.fromJson(item));
      }
    } else {
      for (var item in json['data']) {
        data!.add(SectionItemDTO.fromJson(item));
      }
    }
  }
}
