import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressEntity extends Equatable {
  final int id;
  final int provinceId;
  final String provinceName;
  final int zoneId;
  final String zoneName;
  final String label;
  final double lat;
  final double lng;
  final bool isDefault;
  final bool selectedLocation;
  final String floor;
  final String apartment;
  final String building;
  final String? landmark;

  LatLng get location => LatLng(lat, lng);

  const AddressEntity({
    required this.id,
    required this.provinceId,
    required this.provinceName,
    required this.zoneId,
    required this.zoneName,
    required this.label,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.selectedLocation,
    required this.floor,
    required this.apartment,
    required this.building,
    this.landmark,
  });

  @override
  List<Object?> get props => [
    id,
    provinceId,
    provinceName,
    zoneId,
    zoneName,
    label,
    lat,
    lng,
    isDefault,
    selectedLocation,
    floor,
    apartment,
    building,
    landmark,
  ];
}
