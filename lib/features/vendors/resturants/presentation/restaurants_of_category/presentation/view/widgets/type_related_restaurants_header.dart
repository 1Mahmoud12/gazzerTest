part of '../restaurants_of_category_screen.dart';

// import 'package:flutter/material.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';

// import 'package:gazzer/core/presentation/theme/app_colors.dart';
// import 'package:gazzer/core/presentation/theme/app_gradient.dart';
// import 'package:gazzer/core/presentation/theme/text_style.dart';
// import 'package:gazzer/features/home/presentaion/utils/add_shape_clipper.dart';

class _TypeRelatedRestaurantsHeader extends StatelessWidget {
  const _TypeRelatedRestaurantsHeader({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 50;
    return Column(
      children: [
        SizedBox(
          height: height,
          width: double.infinity,
          child: ClipPath(
            clipper: AddShapeClipper(),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: Grad().bgLinear.copyWith(
                  colors: [
                    Co.buttonGradient.withAlpha(200),
                    Co.bg.withAlpha(0),
                  ],
                  stops: const [0.0, 1],
                ),
              ),
              child: MainAppBar(title: title),
            ),
          ),
        ),
        // DecoratedBox(
        //   decoration: BoxDecoration(
        //     gradient: Grad().bgLinear.copyWith(colors: [Co.buttonGradient.withAlpha(80), Co.bg.withAlpha(0)], stops: const [0.0, 1]),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsetsGeometry.only(top: 16, bottom: 16),
        //     child: Center(child: Text(L10n.tr().eartYourFirstOrderForFree, style: TStyle.blackBold(15))),
        //   ),
        // ),
      ],
    );
  }
}
