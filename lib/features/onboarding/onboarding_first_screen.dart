import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class OnboardingFirstScreen extends StatelessWidget {
  const OnboardingFirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(Assets.assetsPngFoodBg), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Hero(
                    tag: "cloud",
                    child: Image.asset(Assets.assetsPngCloud, fit: BoxFit.fitWidth, width: 500),
                  ),
                  Column(
                    children: [
                      SvgPicture.asset(Assets.assetsSvgCharacter),
                      Text(
                        "Hi Iam Gazzer\nWelcome",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Co.main,
                          shadows: [BoxShadow(color: Color(0x99FF9900), offset: Offset(0, 3), blurRadius: 2)],
                        ),
                      ),
                    ],
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
