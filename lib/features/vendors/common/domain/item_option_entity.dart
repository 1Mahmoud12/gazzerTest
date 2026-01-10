import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

class ItemOptionEntity extends Equatable {
  final String id;
  final String name;
  final bool isRequired;
  final OptionType type;
  final bool controlsPrice;
  final List<SubAddonEntity> subAddons;

  const ItemOptionEntity({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.type,
    required this.controlsPrice,
    this.subAddons = const [],
  });

  @override
  List<Object?> get props => [
    id,
    name,
    isRequired,
    type,
    controlsPrice,
    subAddons,
  ];
}

class SubAddonEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isDefault;
  final bool isFree;
  final OptionType? type;
  final bool? isRequired;
  final bool? controlsPrice;
  final List<SubAddonEntity> subAddons;
  final bool
  isLeafValue; // True when type is null (final value, no more sub-addons)

  const SubAddonEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.isDefault,
    this.isFree = false,
    this.type,
    this.isRequired,
    this.controlsPrice,
    this.subAddons = const [],
    this.isLeafValue = false,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    isDefault,
    isFree,
    type,
    isRequired,
    controlsPrice,
    subAddons,
    isLeafValue,
  ];
}

// Keep old OpionValueEntity for backward compatibility
class OpionValueEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final bool isDefault;

  const OpionValueEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.isDefault,
  });

  @override
  List<Object?> get props => [id, name, price, isDefault];
}
