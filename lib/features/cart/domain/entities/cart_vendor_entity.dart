import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';

class CartVendorEntity extends Equatable {
  final int id;
  final String name;
  final String image;
  final bool isOpen;
  final VendorType type;
  final List<CartItemEntity> items;

  const CartVendorEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.type,
    this.items = const [],
    required this.isOpen,
  });

  @override
  List<Object?> get props => [id, name, image, type, items, isOpen];
}
