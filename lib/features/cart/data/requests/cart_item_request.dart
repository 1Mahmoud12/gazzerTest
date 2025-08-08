import 'package:gazzer/core/presentation/extensions/enum.dart';

class CartableItemRequest {
  final int? cartItemId;
  final int id;
  final CartItemType type;
  final int quantity;
  final String? note;
  final Map<int, Set<int>> options;

  CartableItemRequest({
    required this.cartItemId,
    required this.id,
    required this.type,
    required this.quantity,
    required this.note,
    required this.options,
  });

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
    };
  }
}
