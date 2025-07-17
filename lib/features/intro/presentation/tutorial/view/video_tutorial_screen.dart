import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/widgets/tutorial_header.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/widgets/video_tutorial_card.dart';

class VideoTutorialScreen extends StatelessWidget {
  const VideoTutorialScreen({super.key});
  static const route = '/vidoe-tutorial';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false, iconsColor: Co.secondary),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TutorialHeader(),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: GradientText(text: L10n.tr().dailyOffersForYou, style: TStyle.blackBold(16), gradient: Grad().textGradient),
          ),
          Expanded(
            child: GridView.builder(
              padding: AppConst.defaultPadding,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.45,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const VideoTutorialCard();
              },
            ),
          ),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: GradientText(text: L10n.tr().dailyOffersForYou, style: TStyle.blackBold(16), gradient: Grad().textGradient),
          ),
          Expanded(
            child: GridView.builder(
              padding: AppConst.defaultPadding,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.45,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return const VideoTutorialCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
