import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/title_with_more.dart';

class HomeSuggestedProductsWidget extends StatelessWidget {
  const HomeSuggestedProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        TitleWithMore(title: "Suggested For You", onPressed: () {}),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (context, index) => const VerticalSpacing(12),
          itemBuilder: (context, index) {
            return HorizontalProductCard(product: Fakers.fakeProds[index]);
          },
        ),
      ],
    );
  }
}
