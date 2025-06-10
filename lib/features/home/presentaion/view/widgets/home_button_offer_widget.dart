import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/main_btn.dart';

class HomeButtonOfferWidget extends StatelessWidget {
  const HomeButtonOfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1.1,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Co.buttonGradient.withAlpha(150), Co.bg.withAlpha(0)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [0.0, 1],
          ),
        ),
        child: Row(
          spacing: 20,
          children: [
            const SizedBox.shrink(),
            Image.asset(Assets.assetsPngSandwitch, height: 170, fit: BoxFit.fitHeight),
            const SizedBox.shrink(),

            Expanded(
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GradientText(text: "30%", style: TStyle.blackBold(42), gradient: Grad.radialGradient),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GradientText(
                        text: "Off From\nChicken Burger",
                        style: TStyle.blackBold(14),
                        gradient: Grad.radialGradient,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  MainBtn(
                    onPressed: () {},
                    width: 115,
                    height: 35,

                    text: "Order Now",
                    bgColor: Co.second2,
                    textStyle: TStyle.primaryBold(14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
