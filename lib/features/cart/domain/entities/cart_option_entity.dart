import 'package:equatable/equatable.dart';
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';

class CartOptionEntity extends Equatable {
  final String id;
  final String name;
  final List<CartOptionValueEntity> values;

  const CartOptionEntity({
    required this.id,
    required this.name,
    required this.values,
  });

  CartOptionEntity.fromOption(
    ItemOptionEntity option,
    List<CartOptionValueEntity> vals,
  ) : id = option.id,
      name = option.name,
      values = vals;

  @override
  List<Object?> get props => [id, name, values];
}

class CartOptionValueEntity extends Equatable {
  final int id;
  final String name;
  final double price;

  const CartOptionValueEntity({
    required this.id,
    required this.name,
    required this.price,
  });

  CartOptionValueEntity.fromOptionValue(OpionValueEntity value) : id = value.id, name = value.name, price = value.price;

  @override
  List<Object?> get props => throw UnimplementedError();
}
