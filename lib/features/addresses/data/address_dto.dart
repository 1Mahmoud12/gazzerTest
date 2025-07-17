import 'package:gazzer/features/addresses/domain/address_entity.dart';

class AddressDTO {
  int? id;
  String? name;
  String? address;
  double? lat;
  double? long;
  int? isDefault;
  ProvinceDTO? province;
  ProvinceZoneDTO? provinceZone;

  AddressDTO({this.id, this.name, this.address, this.lat, this.long, this.isDefault, this.province, this.provinceZone});

  AddressDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lat = json['lat'];
    long = json['long'];
    isDefault = json['is_default'];
    province = json['province'] != null ? ProvinceDTO.fromJson(json['province']) : null;
    provinceZone = json['province_zone'] != null ? ProvinceZoneDTO.fromJson(json['province_zone']) : null;
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id!,
      label: name!,
      description: address,
      lat: lat!,
      lng: long!,
      isDefault: isDefault == 1,
      provinceId: province!.id!,
      provinceName: province!.provinceName!,
      zoneId: provinceZone!.id!,
      zoneName: provinceZone!.zoneName!,
      apartment: 0, // Default value, adjust as needed
      building: '', // Default value, adjust as needed
      street: '', // Default value, adjust as needed
      floor: 0, // Default value, adjust as needed
      landmark: null, // Default value, adjust as needed
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
