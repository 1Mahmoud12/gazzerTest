import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/routing/context.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
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
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: AppConst.defaultBorderRadius,
                    image: const DecorationImage(
                      image: AssetImage(Assets.assetsPngVideoTutorialPlaceholder2),
                      fit: BoxFit.cover,
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: AppConst.defaultBorderRadius,
                  ),
                  child: const Center(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Co.white, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(6.0),
                        child: Icon(Icons.play_arrow, size: 32, color: Co.purple),
                      ),
                    ),
                  ),
                ),
              ),
              const HorizontalSpacing(8),
              Expanded(
                flex: 3,
                child: Text("Gazzer Video Tutorial Guide", style: TStyle.blackSemi(13), textAlign: TextAlign.center),
              ),
              const HorizontalSpacing(6),
            ],
          ),
        ),
      ),
    );
  }
}
