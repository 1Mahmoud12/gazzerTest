part of 'product_item_dto.dart';

class MainCategoryDTO extends ProductItemDTO {
  late final int? id;
  late final String? name;
  late final String? image;
  late final String? type;

  MainCategoryDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    image = json['image'];
  }

  MainCategoryEntity toEntity() => MainCategoryEntity(
    id: id!,
    name: name!,
    image: image ?? '',
    type: VendorType.fromString(type ?? ''),
  );
}

class VendorDTO extends ProductItemDTO {
  int? id;
  String? vendorName;
  String? contactPerson;
  String? secondContactPerson;
  String? image;
  String? type;

  VendorDTO({this.id, this.vendorName, this.contactPerson, this.secondContactPerson});

  VendorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendor_name'];
    contactPerson = json['contact_person'];
    secondContactPerson = json['second_contact_person'];
    image = json['image'];
    type = json['type'];
  }

  VendorEntity toEntity() {
    return VendorEntity(
      id: id ?? 0,
      name: vendorName ?? '',
      contactPerson: contactPerson,
      secondContactPerson: secondContactPerson,
      image: image ?? '',
      type: type ?? '',
    );
  }
}
