import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainAppBar, VerticalSpacing;
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_extras_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_image_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_price_summary.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_summary_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_types_widget.dart';

class AddProdctToCartScreen extends StatelessWidget {
  const AddProdctToCartScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                const VerticalSpacing(16),
                const ProductImageWidget(),
                ProductSummaryWidget(product: product),
                const VerticalSpacing(24),
                ProductTypesWidget(product: product),
                const VerticalSpacing(24),
                ProductExtrasWidget(product: product),
                const VerticalSpacing(24),
              ],
            ),
          ),
          const ProductPriceSummary(),
        ],
      ),
    );
  }
}
