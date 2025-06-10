import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/home/presentaion/view/widgets/title_with_more.dart';

class HomeCuisinesWidget extends StatelessWidget {
  const HomeCuisinesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        TitleWithMore(title: "Explore Cuisines", onPressed: () {}),
        SizedBox(
          height: 70,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final cuisne = Fakers.fakeCuisines[index];
              return DecoratedBox(
                decoration: BoxDecoration(
                  border: GradientBoxBorder(gradient: Grad.shadowGrad()),
                  borderRadius: BorderRadius.circular(66),
                  gradient: Grad.bgLinear.copyWith(
                    stops: const [0.0, 1],
                    colors: [const Color(0x55402788), Colors.transparent],
                  ),
                ),
                child: Row(
                  spacing: 6,
                  children: [
                    CircleGradientBorderedImage(image: cuisne.image),
                    Text("${cuisne.name} Cousine", style: TStyle.blackBold(12), textAlign: TextAlign.center),
                    const HorizontalSpacing(8),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox.shrink(),
        SizedBox(
          height: 95,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: Fakers.fakeCuisines.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final cuisne = Fakers.fakeCuisines[index];
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: Column(
                  spacing: 8,
                  children: [
                    Expanded(child: CircleGradientBorderedImage(image: cuisne.image)),
                    Text(cuisne.name, style: TStyle.blackBold(12), overflow: TextOverflow.ellipsis, maxLines: 1,),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
