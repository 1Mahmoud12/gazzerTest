import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/horizontal_product_card.dart';

class HomeSuggestedProductsWidget extends StatelessWidget {
  const HomeSuggestedProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GradientText(
              text: "Suggested For You",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              gradient: Grad.radialGradient,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Co.secondary.withAlpha(25), elevation: 0),
              child: Text("View All", style: TStyle.primarySemi(16)),
            ),
          ],
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (context, index) => const VerticalSpacing(12),
          itemBuilder: (context, index) {
            return const HorizontalProductCard();
          },
        ),
      ],
    );
  }
}
