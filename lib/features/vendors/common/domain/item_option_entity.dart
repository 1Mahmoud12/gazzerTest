
import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

class ItemOptionEntity extends Equatable {
  final int id;
  final String name;
  final bool isRequired;
  final OptionType type;
  final bool controlsPrice;
  final List<OpionValueEntity> values;

  const ItemOptionEntity({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.type,
    required this.controlsPrice,
    required this.values,
  });

  @override
  List<Object?> get props => [id, name, isRequired, type, controlsPrice, values];
}

class OpionValueEntity extends Equatable {
  final int id;
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
