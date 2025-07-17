import 'package:gazzer/features/profile/presentation/model/address_model.dart';

class AddressRequest {
  final int? id;
  final AddressLabel label;
  final String? name;
  final double lat;
  final double long;
  final int provinceId;
  final int provinceZoneId;
  final bool isDefault;
  final int floor;
  final int apartment;
  final String building;
  final String street;
  final String landmark;
  final String? description;

  AddressRequest({
    this.id,
    this.name,
    required this.label,
    required this.lat,
    required this.long,
    required this.provinceId,
    required this.provinceZoneId,
    this.isDefault = false,
    this.floor = 0,
    this.apartment = 0,
    this.building = '',
    this.street = '',
    this.landmark = '',
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': label == AddressLabel.other ? name : label.name,
      'lat': lat,
      'long': long,
      'province_id': provinceId,
      'province_zone_id': provinceZoneId,
      'is_default': isDefault,
      'floor': floor,
      'apartment': apartment,
      'building': building,
      'street': street,
      'landmark': landmark,
      'description': description,
    };
  }
}
