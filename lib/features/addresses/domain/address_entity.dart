class AddressEntity {
  final int id;
  final int provinceId;
  final String provinceName;
  final int zoneId;
  final String zoneName;
  final String label;
  final double lat;
  final double lng;
  final bool isDefault;
  final String street;
  final int floor;
  final int apartment;
  final String building;
  final String? description;
  final String? landmark;

  const AddressEntity({
    required this.id,
    required this.street,
    required this.provinceId,
    required this.provinceName,
    required this.zoneId,
    required this.zoneName,
    required this.label,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.floor,
    required this.apartment,
    required this.building,
    this.description,
    this.landmark,
  });
}
