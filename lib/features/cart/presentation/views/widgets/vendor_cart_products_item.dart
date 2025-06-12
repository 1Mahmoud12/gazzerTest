import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/cart/vendor_products_model.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, VerticalSpacing;
import 'package:gazzer/features/cart/presentation/views/widgets/cart_item_card.dart';

class VendorCartProductsItem extends StatelessWidget {
  const VendorCartProductsItem({super.key, required this.vendor});
  final VendorProductsModel vendor;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          text: vendor.vendorName,
          style: TStyle.blackBold(18),
          gradient: Grad.radialGradient.copyWith(radius: 2, center: Alignment.centerRight),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vendor.cartItems.length,
          shrinkWrap: true,
          separatorBuilder: (context, index) => const VerticalSpacing(12),
          itemBuilder: (context, index) {
            return CartItemCard(item: vendor.cartItems[index]);
          },
        ),
      ],
    );
  }
}
