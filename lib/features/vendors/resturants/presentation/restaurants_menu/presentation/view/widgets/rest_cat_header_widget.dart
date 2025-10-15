import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/main_back_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';

class RestCatHeaderWidget extends StatelessWidget {
  const RestCatHeaderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + (2 * kToolbarHeight);
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        height: height,
        width: constraints.maxWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            OverflowBox(
              alignment: const Alignment(1, 0),
              maxHeight: height,
              minHeight: height,
              maxWidth: 780,
              minWidth: 780,
              child: Hero(
                tag: Tags.spickyShape,
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
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 55),
              child: Row(
                children: [
                  const MainBackIcon(color: Co.purple),
                  Expanded(
                    child: MainSearchWidget(
                      height: 80,
                      borderRadius: 64,
                      hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                    ),
                  ),
                  const IconButton(
                    onPressed: null,
                    icon: Icon(Icons.arrow_back_ios, color: Colors.transparent),
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
