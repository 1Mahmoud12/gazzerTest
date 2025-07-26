import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/cart/cart_item_model.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, VerticalSpacing;
import 'package:gazzer/features/cart/presentation/views/widgets/cart_item_card.dart';

class VendorCartProductsItem extends StatelessWidget {
  const VendorCartProductsItem({super.key, required this.vendorName, required this.cartItems});
  final String vendorName;
  final List<CartItemModel> cartItems;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultPadding,
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText(
            text: vendorName,
            style: TStyle.blackBold(18),
            gradient: Grad().radialGradient.copyWith(radius: 2, center: Alignment.centerRight),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cartItems.length,
            shrinkWrap: true,
            separatorBuilder: (context, index) => const VerticalSpacing(12),
            itemBuilder: (context, index) {
              return CartItemCard(item: cartItems[index]);
            },
          ),
        ],
      ),
    );
  }
}
