import 'package:flutter/material.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/widgets/top_rated_item_details.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .3,
      child: TopRatedItemDetails(
        key: ValueKey(product.id),
        item: product,
        showFavorite: true,
        shadowColor: ValueNotifier(product.color ?? Colors.transparent),
      ),
    );
  }
}
