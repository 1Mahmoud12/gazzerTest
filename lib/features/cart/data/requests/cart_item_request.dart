import 'package:gazzer/core/presentation/extensions/enum.dart';

class CartableItemRequest {
  final int? cartItemId;
  final int id;
  final CartItemType type;
  final int quantity;
  final bool exceedPouch;
  final String? note;
  final Map<int, Set<String>> options;
  final List<Map<String, dynamic>>? orderedWith;

  CartableItemRequest({
    required this.cartItemId,
    required this.id,
    required this.type,
    required this.quantity,
    required this.note,
    required this.options,
    this.orderedWith,
    this.exceedPouch = false,
  });

  CartableItemRequest copyWith({
    int? cartItemId,
    int? id,
    CartItemType? type,
    int? quantity,
    String? note,
    bool? exceedPouch,
    Map<int, Set<String>>? options,
    List<Map<String, dynamic>>? orderedWith,
  }) {
    return CartableItemRequest(
      cartItemId: cartItemId ?? this.cartItemId,
      id: id ?? this.id,
      type: type ?? this.type,
      quantity: quantity ?? this.quantity,
      note: note ?? this.note,
      options: options ?? this.options,
      orderedWith: orderedWith ?? this.orderedWith,
      exceedPouch: exceedPouch ?? this.exceedPouch,
    );
  }

  Map<String, dynamic> toJson() {
    final list = <Map<String, dynamic>>[];
    for (final entry in options.entries) {
      final option = {
        'option_id': entry.key,
        'value_ids': entry.value.map<String>((value) => value.toString()).toList(),
      };
      list.add(option);
    }

    return {
      "cart_item_id": cartItemId,
      'id': id,
      'type': type.value,
      'quantity': quantity,
      'notes': note,
      'options': list.isNotEmpty ? list : null,
      'ordered_with': orderedWith,
      'add_new_pouch_approval': exceedPouch,
    };
  }
}
