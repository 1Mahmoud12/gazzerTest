import 'package:gazzer/core/domain/cart/cart_item_model.dart';

class VendorProductsModel {
  final int id;
  final String vendorName;
  final String vendorImage;
  final List<CartItemModel> cartItems;

  VendorProductsModel({
    required this.id,
    required this.vendorName,
    required this.vendorImage,
    required this.cartItems,
  });
}
