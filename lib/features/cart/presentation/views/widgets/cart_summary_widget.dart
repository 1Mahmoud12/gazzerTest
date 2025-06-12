import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/helper_widgets.dart'
    show DashedBorder, HorizontalSpacing, MainBtn, VerticalSpacing;
import 'package:gazzer/features/checkout/presentation/view/confirm_order.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Row(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: AppConst.defaultInnerBorderRadius,
                              border: GradientBoxBorder(
                                gradient: Grad.shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: MainBtn(
                                onPressed: () {},
                                text: "Add Items",
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                width: double.infinity,
                                height: 0,
                                textStyle: TStyle.secondaryBold(12),
                                bgColor: Co.purple,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Delivery Fee", style: TStyle.secondarySemi(12)),
                              const HorizontalSpacing(6),
                              Text(Helpers.getProperPrice(45), style: TStyle.secondarySemi(12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 12,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: AppConst.defaultInnerBorderRadius,
                              border: GradientBoxBorder(
                                gradient: Grad.shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: MainBtn(
                                onPressed: () {
                                  context.myPush(const ConfirmOrder());
                                },
                                text: "Checkout",
                                textStyle: TStyle.secondaryBold(12),
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(vertical: 6),
                                bgColor: Co.purple,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Total Amount", style: TStyle.secondarySemi(12)),
                              const HorizontalSpacing(12),
                              Text(Helpers.getProperPrice(20.0), style: TStyle.secondarySemi(12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const VerticalSpacing(12),
                const DashedBorder(width: 6, gap: 6, color: Co.secondary),
                const VerticalSpacing(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("TOTAL: ", style: TStyle.secondaryBold(13)),
                    const HorizontalSpacing(12),
                    Text(Helpers.getProperPrice(65), style: TStyle.secondaryBold(13)),
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
