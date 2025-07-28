import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/features/vendors/resturants/common/view/app_bar_row_widget.dart';

class RestCatHeaderWidget extends StatelessWidget {
  const RestCatHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 50 + kToolbarHeight;
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: height,
        width: constraints.maxWidth,
        child: FractionallySizedBox(
          alignment: Alignment.center,
          heightFactor: 1,
          widthFactor: 2,
          child: SizedBox.expand(
            child: Hero(
              tag: Tags.spickyShape,
              child: ClipPath(
                clipper: AddShapeClipper(),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: Grad().bgLinear.copyWith(
                      colors: [Co.buttonGradient.withAlpha(200), Co.bg.withAlpha(0)],
                      stops: const [0.0, 1],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: height * 0.25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.9,

                          child: const AppBarRowWidget(),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.9,
                          child: MainSearchWidget(
                            height: 80,
                            borderRadius: 64,
                            hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
