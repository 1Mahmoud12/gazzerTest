
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

class OfferDTO {
  int? id;
  String? expiredAt;
  double? discount;
  String? discountType;
  int? maxDiscount;

  OfferDTO({this.id, this.expiredAt, this.discount, this.discountType, this.maxDiscount});

  OfferDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expiredAt = json['expired_at'];
    discount = double.tryParse(json['discount'].toString());
    discountType = json['discount_type'];
    maxDiscount = json['max_discount'];
  }
  OfferEntity? toEntityy() {
    if (discount == null || discountType == null) return null;
    return OfferEntity(
      id: id ?? 0,
      expiredAt: expiredAt ?? '',
      discount: discount ?? 0,
      discountType: DiscountType.fromString(discountType ?? ''),
    );
  }
}