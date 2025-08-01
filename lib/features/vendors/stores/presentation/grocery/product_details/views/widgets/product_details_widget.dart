import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/widgets/top_rated_item_details.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({super.key, required this.product});
  final ProductEntity product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 300,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              padding: const EdgeInsets.only(top: 20),
              child: OverflowBox(
                minHeight: 726,
                maxHeight: 726,
                maxWidth: 726,
                minWidth: 726,
                alignment: Alignment.topCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Co.bg,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(24, 4),
                        blurRadius: 17,
                        spreadRadius: 12,
                        color: product.color ?? Colors.transparent,
                      ),
                    ],
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: Grad().shadowGrad(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: OverflowBox(
              minHeight: 464,
              maxHeight: 464,
              maxWidth: 464,
              minWidth: 464,
              alignment: Alignment.bottomCenter,
              child: ClipOval(
                child: DecoratedBox(
                  decoration: BoxDecoration(gradient: Grad().shadowGrad()),
                  child: AnimatedSwitcher(
                    duration: Durations.extralong1,
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: TopRatedItemDetails(
                      key: ValueKey(product.id),
                      item: product,
                      showFavorite: true,
                      shadowColor: ValueNotifier(product.color ?? Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
