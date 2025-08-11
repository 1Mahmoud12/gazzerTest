import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/domain/entities/cart_option_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cartable_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class CartItemEntity extends Equatable {
  final int cartId;
  final CartItemType type;
  final CartableEntity prod;
  final int quantity;
  final List<CartOptionEntity> options;
  final String? notes;

  double get totalPrice => prod.price * quantity; // TODO: calculation
  // double get _basePRice => options.any((e)=>e.)
  const CartItemEntity({
    required this.cartId,
    required this.type,
    required this.quantity,
    required this.prod,
    this.notes,
    this.options = const [],
  });

  static CartItemEntity fromProduct(GenericItemEntity prod) {
    return CartItemEntity(
      cartId: 0,
      type: prod is PlateEntity ? CartItemType.plate : CartItemType.product,
      prod: CartableEntity(
        id: prod.id,
        name: prod.name,
        price: prod.price,
        priceBeforeDiscount: prod.priceBeforeDiscount,
        image: prod.image,
      ),
      quantity: 1, // Default quantity
      options: [],
      notes: null,
    );
  }

  CartItemEntity copyWith({
    int? id,
    CartItemType? type,
    int? quantity,
    String? notes,
    List<CartOptionEntity>? options,
    CartableEntity? prod,
  }) {
    return CartItemEntity(
      cartId: id ?? this.cartId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      notes: notes ?? this.notes,
      prod: prod ?? this.prod,
      options: options ?? List.from(this.options), // Create a new list to ensure state change detection
    );
  }

  @override
  List<Object?> get props => [cartId, type, quantity, notes, options, prod];
}
