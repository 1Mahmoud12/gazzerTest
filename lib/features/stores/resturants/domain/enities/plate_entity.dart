class PlateEntity {
  final int id;
  final int categoryPlateId;
  final String name;
  final String description;
  final String image;
  final double price;
  final double? priceBeforeDiscount;
  final double rate;
  final List<PlateOptionsEnitiy> options;

  PlateEntity({
    required this.id,
    required this.categoryPlateId,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.priceBeforeDiscount,
    this.rate = 0.0,
    required this.options,
  });
}

class PlateOptionsEnitiy {
  final bool isRequired;
  final String name;
  final bool isMultiple;
  final List<SingleOptionEntity> options;

  PlateOptionsEnitiy({
    required this.isRequired,
    required this.name,
    required this.isMultiple,
    required this.options,
  });
}

class SingleOptionEntity {
  final int id;
  final String name;
  final double price;

  SingleOptionEntity({
    required this.id,
    required this.name,
    required this.price,
  });
}
