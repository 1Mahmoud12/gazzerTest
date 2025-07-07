import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, HorizontalSpacing;
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';

class ProductExtrasWidget extends StatelessWidget {
  const ProductExtrasWidget({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(text: L10n.tr().alsoOrderWith, style: TStyle.blackBold(18)),

        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              return SizedBox(width: 150, child: VerticalProductCard(product: Fakers.fakeProds[index], canAdd: true, fontFactor: 0.9));
            },
          ),
        ),
      ],
    );
  }
}
