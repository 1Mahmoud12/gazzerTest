part of 'product_item_dto.dart';

class CategoryDTO extends ProductItemDTO {
  final int? id;
  final String? name;
  final String? image;
  final String? type;

  CategoryDTO(this.id, this.name, this.image, this.type);

  CategoryDTO.fromJson(Map<String, dynamic> json) : id = json['id'], name = json['name'], type = json['type'], image = json['image'];

  CategoryEntity toCategoryEntity() => CategoryEntity(id!, name!, image ?? '', CategoryType.fromString(type ?? ''));
}

class VendorDTO extends ProductItemDTO {
  int? id;
  String? vendorName;
  String? contactPerson;
  String? secondContactPerson;

  VendorDTO({this.id, this.vendorName, this.contactPerson, this.secondContactPerson});

  VendorDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorName = json['vendor_name'];
    contactPerson = json['contact_person'];
    secondContactPerson = json['second_contact_person'];
  }

  VendorEntity toEntity() {
    return VendorEntity(
      id: id ?? 0,
      name: vendorName ?? '',
      contactPerson: contactPerson,
      secondContactPerson: secondContactPerson,
      image: Fakers().netWorkImage,
    );
  }
}
