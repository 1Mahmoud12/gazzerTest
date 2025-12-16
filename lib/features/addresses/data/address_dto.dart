import 'package:gazzer/features/addresses/domain/address_entity.dart';

class AddressDTO {
  int? id;
  String? name;
  String? address;
  double? lat;
  double? long;
  int? isDefault;
  int? selectedLocation;
  ProvinceDTO? province;
  ProvinceZoneDTO? provinceZone;
  String? building;
  String? floor;
  String? apartment;

  AddressDTO({this.id, this.name, this.address, this.lat, this.long, this.isDefault, this.selectedLocation, this.province, this.provinceZone});

  AddressDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = double.tryParse(json['lat'].toString()) ?? 0.0;
    long = double.tryParse(json['long'].toString()) ?? 0.0;
    isDefault = json['is_default'];
    province = json['province'] != null ? ProvinceDTO.fromJson(json['province']) : null;
    provinceZone = json['province_zone'] != null ? ProvinceZoneDTO.fromJson(json['province_zone']) : null;
    building = json['building'];
    floor = json['floor'];
    apartment = json['apartment'];
    selectedLocation = json['selected_location'] ?? 0;
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id!,
      label: name!,
      lat: lat!,
      lng: long!,
      isDefault: isDefault == 1,
      provinceId: province!.id!,
      provinceName: province!.provinceName!,
      zoneId: provinceZone!.id!,
      zoneName: provinceZone!.zoneName!,
      building: building ?? '',
      apartment: apartment ?? '',
      selectedLocation: selectedLocation == 1,
      floor: floor ?? '',
      landmark: address ?? '',
    );
  }
}

class ProvinceDTO {
  int? id;
  String? provinceName;

  ProvinceDTO({this.id, this.provinceName});

  ProvinceDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provinceName = json['province_name'];
  }
}

class ProvinceZoneDTO {
  int? id;
  String? zoneName;

  ProvinceZoneDTO({this.id, this.zoneName});

  ProvinceZoneDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zoneName = json['zone_name'];
  }
}
