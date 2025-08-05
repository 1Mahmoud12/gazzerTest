import 'package:gazzer/features/profile/presentation/model/address_model.dart';

class AddressRequest {
  int? id;
  final AddressLabel label;
  final String? name;
  final double lat;
  final double long;
  final int provinceId;
  final int provinceZoneId;
  final String floor;
  final String apartment;
  final String building;
  final String landmark;
  final bool isDefault;

  AddressRequest({
    this.id,
    this.name,
    required this.label,
    required this.lat,
    required this.long,
    required this.provinceId,
    required this.provinceZoneId,
    required this.floor,
    required this.apartment,
    required this.building,
    required this.landmark,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': label == AddressLabel.other ? name : label.name,
      'lat': lat,
      'long': long,
      'is_default': isDefault,
      'province_id': provinceId,
      'province_zone_id': provinceZoneId,
      'building': building,
      'floor': floor,
      'apartment': apartment,
      'address': landmark,
      'street': landmark,
    };
  }
}
