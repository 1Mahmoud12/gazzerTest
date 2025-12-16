import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/cart/data/dtos/cart_item_dto.dart';
import 'package:gazzer/features/cart/domain/entities/cart_vendor_entity.dart';

class CartVendorDTO {
  int? storeId;
  String? storeName;
  String? storeImage;
  String? type;
  bool? isOpen;
  List<CartItemDTO>? items;

  CartVendorDTO.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeImage = json['store_image'];
    isOpen = json['is_open'] == 1;
    type = json['type'];
    if (json['items'] != null) {
      items = <CartItemDTO>[];
      json['items'].forEach((v) {
        items!.add(CartItemDTO.fromJson(v, v['cartable_type'].toString().toLowerCase() == 'plate'));
      });
    }
  }

  CartVendorEntity toEntity() {
    return CartVendorEntity(
      id: storeId ?? 0,
      name: storeName ?? '',
      image: storeImage ?? '',
      isOpen: isOpen ?? true,
      type: VendorType.fromString(type.toString().toLowerCase()),
      items: items?.map((item) => item.toEntity()).toList() ?? [],
    );
  }
}
