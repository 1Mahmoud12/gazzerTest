import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/widgets/main_btn.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RestCatCarousal extends StatefulWidget {
  const RestCatCarousal({super.key});

  @override
  State<RestCatCarousal> createState() => _RestCatCarousalState();
}

class _RestCatCarousalState extends State<RestCatCarousal> {
  final PageController controller = PageController(viewportFraction: 1);
  late final Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if ((controller.page ?? 0) >= Fakers.restCatAdds.length - 1) {
        controller.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      } else {
        controller.nextPage(duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Container(
        constraints: const BoxConstraints(maxHeight: 320),
        decoration: BoxDecoration(
          gradient: Grad.bgLinear.copyWith(colors: [Co.purple.withAlpha(80), Co.bg.withAlpha(0)], stops: [0.0, 1]),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                itemCount: Fakers.restCatAdds.length,
                scrollDirection: Axis.horizontal,
                padEnds: true,
                onPageChanged: (value) {},
                itemBuilder: (context, index) {
                  final add = Fakers.restCatAdds[index];
                  return Padding(
                    padding: AppConst.defaultHrPadding,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              // Text.rich(
                              //   TextSpan(
                              //     children: [
                              //       WidgetSpan(
                              //         child: Row(
                              //           children: [
                              //             Text(
                              //               add.title,
                              //               style: TStyle.primaryBold(22).copyWith(color: Co.white),
                              //               textAlign: TextAlign.start,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       TextSpan(
                              //         text: "${add.discountPercentage.toInt()}%\n   ",
                              //         style: TStyle.primaryBold(48).copyWith(color: Co.white),
                              //       ),
                              //       TextSpan(
                              //         text: add.title,
                              //         style: TStyle.primaryBold(22).copyWith(color: Co.white),
                              //       ),
                              //     ],
                              //   ),
                              //   textAlign: TextAlign.start,
                              // ),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GradientText(
                                      text: "${add.discountPercentage.toInt()}% ",
                                      style: TStyle.primaryBold(48, isInter: true).copyWith(color: Co.white),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(add.title, style: TStyle.primaryBold(18), textAlign: TextAlign.start),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: MainBtn(
                                  text: "Order now",
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                  height: 0,
                                  bgColor: Co.second2,
                                  textStyle: TStyle.primaryBold(14),
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Image.asset(
                              Fakers.restCatAdds[index].image,
                              fit: BoxFit.cover,
                              height: constraints.maxHeight * 0.8,
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SmoothPageIndicator(
              controller: controller, // PageController
              count: Fakers.restCatAdds.length,
              effect:
                  // SwapEffect(
                  //   dotWidth: 10,
                  //   dotHeight: 10,
                  //   activeDotColor: Co.darkPurple,
                  //   dotColor: Co.darkPurple.withAlpha(100),
                  //   spacing: 8,
                  //   type: SwapType.zRotation
                  // )
                  CustomizableEffect(
                    dotDecoration: DotDecoration(
                      height: 7,
                      width: 7,
                      color: Co.darkPurple,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    activeDotDecoration: DotDecoration(
                      height: 7,
                      width: 27,
                      color: Co.darkPurple,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
