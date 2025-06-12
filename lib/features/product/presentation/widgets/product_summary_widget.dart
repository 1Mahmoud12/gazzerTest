import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';

class ProductSummaryWidget extends StatelessWidget {
  const ProductSummaryWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          spacing: 12,
          children: [
            GradientText(text: product.name.toUpperCase(), style: TStyle.blackBold(20), gradient: Grad.textGradient),
            const Spacer(),
            Text("EG", style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow)),
            Text(
              product.price.toStringAsFixed(2),
              style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow),
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            Text("Valid until May 15, 2025", style: TStyle.blackRegular(14)),
            const Spacer(),
            const Icon(Icons.star, color: Co.secondary, size: 20),
            Text(product.rate.toStringAsFixed(1), style: TStyle.secondaryBold(13)),
          ],
        ),
      ],
    );
  }
}
