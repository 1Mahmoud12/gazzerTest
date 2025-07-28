import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart'
    show GradientText, HorizontalSpacing;
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/ordered_with_card.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/ordered_with_entityy.dart';

class OrderedWithComponent extends StatelessWidget {
  const OrderedWithComponent({super.key, required this.product});
  final List<OrderedWithEntityy> product;
  @override
  Widget build(BuildContext context) {
    // if (product.isEmpty) {
    //   return const SizedBox.shrink();
    // }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        GradientText(text: L10n.tr().alsoOrderWith, style: TStyle.blackBold(18)),

        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: product.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 150,
                child: OrderedWithCard(
                  product: product[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
