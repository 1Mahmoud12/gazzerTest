import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/hero_tags.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';

class RestCatHeaderWidget extends StatefulWidget {
  const RestCatHeaderWidget({super.key});

  @override
  State<RestCatHeaderWidget> createState() => _RestCatHeaderWidgetState();
}

class _RestCatHeaderWidgetState extends State<RestCatHeaderWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.paddingOf(context).top + kToolbarHeight + 50;
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            height: height,
            width: constraints.maxWidth,
            child: FractionallySizedBox(
              alignment: Alignment.center,
              heightFactor: 1,
              widthFactor: 2,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  SizedBox.expand(
                    child: Hero(
                      tag: Tags.spickyShape,
                      child: ClipPath(
                        clipper: AddShapeClipper(),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: Grad.bgLinear.copyWith(
                              colors: [Co.buttonGradient.withAlpha(200), Co.bg.withAlpha(0)],
                              stops: const [0.0, 1],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: height * 0.25),
                            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                                
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0.3),
                    child: SizedBox(
                      width: constraints.maxWidth * 0.9,
                      child: Hero(
                        tag: Tags.searchBar,
                        child: MainTextField(
                          controller: controller,
                          height: 80,
                          borderRadius: 64,
                          bgColor: Colors.transparent,
                          hintText: "Search for stores, items, or categories",
                          prefix: const Icon(Icons.search, color: Co.purple, size: 32),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        GradientText(text: "Best MENU OF Restaurants", style: TStyle.primaryBold(24)),
        Text("Choose Your Favorite", style: TStyle.greyBold(14).copyWith(letterSpacing: 2)),
      ],
    );
  }
}
