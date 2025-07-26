import 'package:gazzer/core/domain/entities/banner_entity.dart';

class BannerDTO {
  int? id;
  String? type;
  String? image;
  String? title;
  String? subtitle;
  String? expiredAt;
  int? isAnimated;
  int? targetableId;
  String? targetableType;
  String? backgroundColor;
  num? discountPercent;
  List<String>? images;
  // String? createdAt;
  // List<Null>? timeRemain;
  // int? bannerableId;
  // String? bannerableType;

  BannerDTO({
    this.id,
    this.type,
    this.image,
    this.title,
    this.subtitle,
    // this.createdAt,
    this.expiredAt,
    // this.timeRemain,
    this.isAnimated,
    // this.bannerableId,
    // this.bannerableType,
    this.targetableId,
    this.targetableType,
    this.backgroundColor,
    this.discountPercent,
    this.images,
  });

  BannerDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    image = json['image'].toString().contains('http') ? json['image'] : "https://gazzer-dev-do.mostafa.cloud/defaults/${json['image']}";
    title = json['title'];
    subtitle = json['subtitle'];
    isAnimated = json['is_animated'];
    targetableId = json['targetable_id'];
    targetableType = json['targetable_type'];
    backgroundColor = json['background_color'];
    discountPercent = json['discount_percent'];
    expiredAt = json['expired_at'];
    images = json['images'] != null ? List<String>.from(json['images']) : null;
    // createdAt = json['created_at'];
    // bannerableId = json['bannerable_id'];
    // bannerableType = json['bannerable_type'];
    // if (json['time_remain'] != null) {
    //   timeRemain = <Null>[];
    //   json['time_remain'].forEach((v) {
    //     timeRemain!.add(new Null.fromJson(v));
    //   });
    // }
  }

  BannerEntity toEntity() {
    return BannerEntity(
      id: id ?? 0,
      type: BannerType.fromString(type ?? ''),
      image: image,
      title: title,
      subtitle: subtitle,
      expiredAt: expiredAt,
      isAnimated: isAnimated,
      targetableId: targetableId,
      targetableType: targetableType,
      backgroundColor: backgroundColor,
      discountPercent: discountPercent,
      images: images,
    );
  }
}
