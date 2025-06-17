import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';

class VideoTutorialCard extends StatelessWidget {
  const VideoTutorialCard({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: GradientBoxBorder(gradient: Grad.shadowGrad()),

        borderRadius: AppConst.defaultBorderRadius,
      ),
      child: ClipRRect(
        borderRadius: AppConst.defaultBorderRadius,
        child: InkWell(
          onTap: () {
            context.myPushReplacment(const IntroVideoTutorialScreen(videoLink: ''));
          },
          child: Row(
            spacing: 12,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: AppConst.defaultBorderRadius,
                  child: Image.asset(
                    Assets.assetsPngVideoTutorialPlaceholder2,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text("Gazzer Video Tutorial Guide", style: TStyle.blackSemi(14), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
