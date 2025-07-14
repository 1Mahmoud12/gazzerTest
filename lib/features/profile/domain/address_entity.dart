class AddressEntity {
  final int id;
  final int provinceId;
  final int zoneId;
  final String label;
  final double lat;
  final double lng;
  final bool isDefault;
  final String street;
  final int floor;
  final int apartmentNum;
  final String? description;
  final String? landmark;

  AddressEntity({
    required this.id,
    required this.street,
    required this.provinceId,
    required this.zoneId,
    required this.label,
    required this.lat,
    required this.lng,
    required this.isDefault,
    required this.floor,
    required this.apartmentNum,
    this.description,
    this.landmark,
  });
}
