import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/domain/entities/cart_option_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cart_ordered_with_entity.dart';
import 'package:gazzer/features/cart/domain/entities/cartable_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class CartItemEntity extends Equatable {
  final int cartId;
  final CartItemType type;
  final CartableEntity prod;
  final int quantity;
  final num itemPrice;
  final int? quantityInStock;
  final List<CartOptionEntity> options;
  final List<CartOrderedWithEntity> orderedWith;
  final String? notes;

  double get totalPrice {
    final basePrice = itemPrice * quantity;
    final orderedWithTotal = orderedWith.fold<double>(
      0.0,
      (sum, item) => sum + item.totalPrice,
    );
    return basePrice + orderedWithTotal; // TODO: include options pricing
  }

  // double get _basePRice => options.any((e)=>e.)
  const CartItemEntity({
    required this.cartId,
    required this.type,
    required this.quantity,
    required this.prod,
    required this.itemPrice,
    this.quantityInStock,
    this.notes,
    this.options = const [],
    this.orderedWith = const [],
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
      orderedWith: [],
      notes: null,
      itemPrice: 0,
    );
  }

  CartItemEntity copyWith({
    int? id,
    CartItemType? type,
    int? quantity,
    int? quantityInStock,
    String? notes,
    List<CartOptionEntity>? options,
    List<CartOrderedWithEntity>? orderedWith,
    CartableEntity? prod,
    double? itemPrice,
  }) {
    return CartItemEntity(
      cartId: id ?? this.cartId,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      quantityInStock: quantityInStock ?? this.quantityInStock,
      notes: notes ?? this.notes,
      prod: prod ?? this.prod,
      options:
          options ??
          List.from(
            this.options,
          ), // Create a new list to ensure state change detection
      orderedWith: orderedWith ?? List.from(this.orderedWith),
      itemPrice: itemPrice ?? this.itemPrice,
    );
  }

  @override
  List<Object?> get props => [
    cartId,
    type,
    quantity,
    quantityInStock,
    notes,
    options,
    orderedWith,
    prod,
  ];
}
