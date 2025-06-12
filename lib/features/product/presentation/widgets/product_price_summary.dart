import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainBtn, HorizontalSpacing;
import 'package:gazzer/features/product/presentation/widgets/increment_widget.dart';

class ProductPriceSummary extends StatelessWidget {
  const ProductPriceSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
        gradient: Grad.radialGradient,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
          gradient: Grad.linearGradient,
        ),
        child: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(child: IncrementWidget()),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: AppConst.defaultInnerBorderRadius,
                          border: GradientBoxBorder(
                            gradient: Grad.shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: MainBtn(
                            onPressed: () {},
                            text: "Add to Cart",
                            textStyle: TStyle.secondaryBold(12),
                            bgColor: Co.purple,
                            height: 0,
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text("Selected Type", style: TStyle.secondaryBold(13)),
                      ),
                    ),
                    const HorizontalSpacing(12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),

                        child: Row(
                          children: [
                            Text("TOTAL:", style: TStyle.secondaryBold(13)),
                            const HorizontalSpacing(12),
                            Text(Helpers.getProperPrice(20.0), style: TStyle.secondaryBold(13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
