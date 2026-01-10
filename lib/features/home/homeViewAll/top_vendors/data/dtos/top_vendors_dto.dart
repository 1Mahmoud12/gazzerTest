import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/dto/store_info_dto.dart';

class TopVendorsDto {
  TopVendorsDto({this.status, this.message, this.data, this.pagination});

  final String? status;
  final String? message;
  final TopVendorsData? data;
  final PaginationInfo? pagination;

  factory TopVendorsDto.fromJson(Map<String, dynamic> json) {
    return TopVendorsDto(
      status: json['status'],
      message: json['message'],
      data: json['data'] == null ? null : TopVendorsData.fromJson(json['data']),
      pagination: json['pagination'] == null ? null : PaginationInfo.fromJson(json['pagination']),
    );
  }
}

class TopVendorsData {
  TopVendorsData({required this.entities, this.banner});

  final List<TopVendor> entities;
  final Banner? banner;

  factory TopVendorsData.fromJson(Map<String, dynamic> json) {
    return TopVendorsData(
      entities: json['entities'] == null ? [] : List<TopVendor>.from(json['entities']!.map((x) => TopVendor.fromJson(x))),
      banner: json['banner'] == null ? null : Banner.fromJson(json['banner']),
    );
  }
}

class TopVendor {
  TopVendor({this.id, this.vendorName, this.contactPerson, this.secondContactPerson, this.image, this.type, this.storeInfo});

  final int? id;
  final String? vendorName;
  final String? contactPerson;
  final String? secondContactPerson;
  final String? image;
  final String? type;
  final StoreInfo? storeInfo;

  factory TopVendor.fromJson(Map<String, dynamic> json) {
    return TopVendor(
      id: json['id'],
      vendorName: json['vendor_name'],
      contactPerson: json['contact_person'],
      secondContactPerson: json['second_contact_person'],
      image: json['image'],
      type: json['type'],
      storeInfo: json['store_info'] == null ? null : StoreInfo.fromJson(json['store_info']),
    );
  }
}

class Banner {
  Banner({
    this.id,
    this.type,
    this.image,
    this.title,
    this.subtitle,
    this.page,
    this.expiredAt,
    this.isAnimated,
    this.bannerableId,
    this.targetableId,
    this.targetableType,
    this.backgroundColor,
    this.discountPercent,
    this.buttonDisplayed,
    this.buttonText,
    this.images,
  });

  final int? id;
  final String? type;
  final String? image;
  final String? title;
  final String? subtitle;
  final String? page;
  final String? expiredAt;
  final int? isAnimated;
  final int? bannerableId;
  final int? targetableId;
  final String? targetableType;
  final String? backgroundColor;
  final dynamic discountPercent;
  final int? buttonDisplayed;
  final String? buttonText;
  final List<dynamic>? images;

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      type: json['type'],
      image: json['image'],
      title: json['title'],
      subtitle: json['subtitle'],
      page: json['page'],
      expiredAt: json['expired_at'],
      isAnimated: json['is_animated'],
      bannerableId: json['bannerable_id'],
      targetableId: json['targetable_id'],
      targetableType: json['targetable_type'],
      backgroundColor: json['background_color'],
      discountPercent: json['discount_percent'],
      buttonDisplayed: json['button_displayed'],
      buttonText: json['button_text'],
      images: json['images'] == null ? [] : List<dynamic>.from(json['images']!.map((x) => x)),
    );
  }
}
