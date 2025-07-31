import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/ordered_with_dto.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_details_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateDetailsResponse {
  late final PlateEntity plate;
  late final List<PlateOptionEntity> options;
  late final List<OrderedWithEntity> orderedWith;

  PlateDetailsResponse.fromJson(Map<String, dynamic> json) {
    final platedetails = PlateDetailsDTO.fromJson(json['data']);
    plate = platedetails.toEntity();
    options = platedetails.toOptionsEntity();
    orderedWith = <OrderedWithEntity>[];

    if (json['data']['ordered_with'] != null) {
      json['data']['ordered_with'].forEach((v) {
        orderedWith.add(OrderedWithDTO.fromJson(v).toEntity());
      });
    }
  }
}
