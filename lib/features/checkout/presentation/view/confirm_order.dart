import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/option_btn.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/checkout/presentation/view/post_checkout_screen.dart';

class ConfirmOrder extends StatelessWidget {
  const ConfirmOrder({super.key});

  @override
  Widget build(BuildContext context) {
    final btnText = ["Add Promo Code", "Add Delivery Instructions", "Add Tip"];
    return Scaffold(
      appBar: AppBar(
        title: GradientText(text: "Confirm Order", style: TStyle.blackBold(18)),
      ),
      body: ListView(
        padding: AppConst.defaultPadding,
        children: [
          Text("Order Summary", style: TStyle.blackBold(16)),
          const VerticalSpacing(24),
          SizedBox(
            height: 250,
            child: ListView.separated(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final cartProd = Fakers.fakecartItems[index];
                return SizedBox(
                  width: 180,
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black26),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Image.asset(cartProd.image, fit: BoxFit.cover, width: double.infinity),
                          ),
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: cartProd.name, style: TStyle.blackBold(14)),
                                    const TextSpan(text: "\n"),
                                    const TextSpan(text: "Qty:"),
                                    TextSpan(text: "${cartProd.quantity}", style: TStyle.blackBold(13)),
                                    const TextSpan(text: "\n"),
                                    const TextSpan(text: "Price: "),
                                    TextSpan(text: Helpers.getProperPrice(cartProd.price), style: TStyle.blackSemi(13)),
                                  ],
                                  style: TStyle.blackSemi(13),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const VerticalSpacing(24),

          ...List.generate(btnText.length, (index) {
            return Padding(
              padding: const EdgeInsetsGeometry.symmetric(vertical: 12),
              child: OptionBtn(
                onPressed: () {},
                radius: 16,
                text: btnText[index],
                textStyle: TStyle.primaryBold(14),
                height: 0,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            );
          }),
          const VerticalSpacing(32),
          OptionBtn(
            onPressed: () {
              context.myPush(const PostCheckoutScreen());
            },
            height: 0,
            padding: const EdgeInsets.symmetric(vertical: 8),
            text: "Confirm Order",
            textStyle: TStyle.primaryBold(14),
          ),
        ],
      ),
    );
  }
}
