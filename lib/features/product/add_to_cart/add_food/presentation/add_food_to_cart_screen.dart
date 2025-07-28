import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show MainAppBar, VerticalSpacing;
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_extras_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_image_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_price_summary.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_summary_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/product_types_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/widgets/add_special_note.dart';
import 'package:go_router/go_router.dart';

part 'add_food_to_cart_screen.g.dart';

@TypedGoRoute<AddFoodToCartRoute>(path: AddFoodToCartScreen.routeWzExtra)
@immutable
class AddFoodToCartRoute extends GoRouteData with _$AddFoodToCartRoute {
  const AddFoodToCartRoute({required this.$extra});
  final GenericItemEntity $extra;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AddFoodToCartScreen(product: $extra);
  }
}

class AddFoodToCartScreen extends StatelessWidget {
  const AddFoodToCartScreen({super.key, required this.product});
  final GenericItemEntity product;
  static const routeWzExtra = '/add-to-cart';

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
                const OrderedWithComponent(product: []),
                const VerticalSpacing(24),
                AddSpecialNote(
                  onNoteChange: (note) {
                    // Handle note change if needed
                  },
                ),
              ],
            ),
          ),
          const ProductPriceSummary(),
        ],
      ),
    );
  }
}
