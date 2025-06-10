import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/products/vertical_product_card.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/title_with_more.dart';

class DailyOffersWidget extends StatelessWidget {
  const DailyOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        TitleWithMore(title: "Daily Offers For You", titleStyle: TStyle.primaryBold(16), onPressed: () {}),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.88,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return VerticalProductCard(product: Fakers.fakeProds[index], canAdd: false);
          },
        ),
      ],
    );
  }
}
