import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/views/components/main_layout/views/main_layout.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/option_btn.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/video_tutorial_screen.dart';

class TutorialBottomSheet extends StatelessWidget {
  const TutorialBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: OptionBtn(
              onPressed: () {
                context.myPushReplacment(const MainLayout());
              },
              text: "Skip",
            ),
          ),
          Expanded(
            child: OptionBtn(
              onPressed: () {
                context.myPushReplacment(const VideoTutorialScreen());
              },
              text: "Learn More",
            ),
          ),
        ],
      ),
    );
  }
}
