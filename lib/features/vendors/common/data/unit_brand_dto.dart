class ItemUnitBrandDTO {
  int? id;
  double? price;
  double? conversionFactor;
  BrandDTO? brand;

  ItemUnitBrandDTO({this.id, this.price, this.conversionFactor, this.brand});

  ItemUnitBrandDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = double.tryParse(json['price'].toString());
    conversionFactor = double.tryParse(json['conversion_factor'].toString());
    brand = json['brand'] != null ? BrandDTO.fromJson(json['brand']) : null;
  }

  ItemUnitBrandEntity toEntity() {
    return ItemUnitBrandEntity(
      id: id ?? 0,
      price: price ?? 0,
      conversionFactor: conversionFactor ?? 1,
      brand: brand?.toEntity(),
    );
  }
}

class BrandDTO {
  int? id;
  String? brandName;

  BrandDTO({this.id, this.brandName});

  BrandDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brandName = json['brand_name'];
  }

  BrandEntity toEntity() {
    return BrandEntity(id: id ?? 0, brandName: brandName ?? '');
  }
}

class ItemUnitBrandEntity {
  int? id;
  double? price;
  double? conversionFactor;
  BrandEntity? brand;

  ItemUnitBrandEntity({this.id, this.price, this.conversionFactor, this.brand});
}

class BrandEntity {
  int? id;
  String? brandName;

  BrandEntity({this.id, this.brandName});
}
