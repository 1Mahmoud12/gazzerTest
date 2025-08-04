import 'package:flutter/material.dart';

enum BannerType {
  image('Image'),
  detailed('Detailed'),
  sliderHorizontal('SliderHorizontal'),
  sliderVertical('SliderVertical'),
  countdown('Countdown'),
  shaking('Shaking'),
  unknown('Unknown');
  /*
'Image';
'Detailed';
'SliderVertical';
'SliderHorizontal';
'Countdown';
'Shaking';
*/

  final String value;

  const BannerType(this.value);

  static BannerType fromString(String value) {
    return BannerType.values.firstWhere((e) => e.value == value, orElse: () => BannerType.unknown);
  }
}

class BannerEntity {
  final int id;
  final BannerType type;
  final String? image;
  final String? title;
  final String? subtitle;
  final String? expiredAt;
  final int? isAnimated;
  final int? targetableId;
  final String? targetableType;
  final String? backgroundColor;
  final num? discountPercent;
  final List<String>? images;
  final Offset? offset;
  final String? backgroundImage;
  final String? foreGroundImage;

  const BannerEntity({
    required this.id,
    required this.type,
    this.image,
    this.title,
    this.subtitle,
    this.expiredAt,
    this.isAnimated,
    this.targetableId,
    this.targetableType,
    this.backgroundColor,
    this.discountPercent,
    this.images,
    this.offset,
    this.backgroundImage,
    this.foreGroundImage,
  });
}
