import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/generic_item_dto.dart';

class PlateDetailsDTO {
  int? id;
  String? plateName;
  String? plateDescription;
  String? rate;
  int? rateCount;
  String? appPrice;
  List<Options>? options;

  /// missing
  String? image;

  /// unused
  int? storeId;
  String? price;
  String? itemType;
  int? plateCategoryId;
  List<String>? tags;
  OfferDTO? offer;
  String? badge;

  PlateDetailsDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    plateName = json['plate_name'];
    plateCategoryId = json['plate_category_id'];
    plateDescription = json['plate_description'];
    price = json['price'];
    rate = json['rate'];
    rateCount = json['rate_count'];
    appPrice = json['app_price'];
    itemType = json['item_type'];
    image = json['plate_image'];
    badge = json['badge'] ?? '';
    if (json['tags'] != null) {
      tags = [];
      json['tags'].forEach((tag) {
        tags!.add(tag.toString());
      });
    }
    if (json['options'] != null) {
      try {
        options = <Options>[];
        json['options'].forEach((v) {
          options!.add(Options.fromJson(v));
        });
      } catch (e) {
        print(' !!! Opions parsing error ${e.toString()}');
      }
    }
    offer = json['offer'] != null ? OfferDTO.fromJson(json['offer']) : null;
  }

  PlateEntity toEntity() {
    return PlateEntity(
      id: id ?? 0,
      name: plateName ?? '',
      price: double.tryParse(appPrice ?? '0') ?? 0.0,
      rate: double.tryParse(rate ?? '0') ?? 0.0,
      reviewCount: rateCount ?? 0,
      description: plateDescription ?? '',
      categoryPlateId: plateCategoryId ?? 0,
      image: image ?? '',
      tags: tags,
      offer: offer?.toOfferEntity(),
      badge: badge,
      outOfStock: false,
    );
  }

  List<ItemOptionEntity> toOptionsEntity() {
    final loadedOptions = options?.map((e) => e.toEntity());
    final nonNullOptions = loadedOptions?.where((e) => e != null).map((e) => e as ItemOptionEntity).toList();
    return nonNullOptions ?? [];
  }
}

class Options {
  int? id;
  String? name;
  String? type;
  int? required;
  int? controlsBasePrice;
  List<Values>? values;

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    required = json['required'];
    controlsBasePrice = json['controls_base_price'];
    if (json['values'] != null) {
      values = <Values>[];
      json['values'].forEach((v) {
        values!.add(Values.fromJson(v));
      });
    }
  }

  ItemOptionEntity? toEntity() {
    try {
      final option = ItemOptionEntity(
        id: id!,
        name: name!,
        isRequired: required == 1,
        type: OptionType.fromString(type ?? ''),
        controlsPrice: controlsBasePrice == 1,
        values: values!.map((e) => e.toEntity()).toList(),
      );
      return option;
    } catch (e) {
      return null;
    }
  }
}

class Values {
  int? id;
  String? name;
  String? price;
  int? isFree;
  int? isDefault;

  Values.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isFree = json['is_free'];
    isDefault = json['is_default'];
  }

  OpionValueEntity toEntity() {
    return OpionValueEntity(
      id: id!,
      name: name ?? '',
      price: double.tryParse(price ?? '0') ?? 0.0,
      isDefault: isDefault == 1,
    );
  }
}
