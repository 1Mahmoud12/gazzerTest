import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';

/// A reusable success dialog that shows a customizable icon, title and subtitle.
/// The dialog mimics a celebratory card with rounded corners and an optional
/// confetti/additional decoration in the background.
Future<void> showSuccessDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  required String iconAsset,
  String? additionalAsset,
  bool showCelebrate = true,
  Widget? additionalWidget,
}) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: _SuccessDialogContent(
        title: title,
        subTitle: subTitle,
        iconAsset: iconAsset,
        showCelebrate: showCelebrate,
        additionalWidget: additionalWidget,
        additionalAsset: additionalAsset ?? Assets.additionalSuccessfullyIc,
      ).animate().scale().fade(),
    ),
  );
}

class _SuccessDialogContent extends StatelessWidget {
  const _SuccessDialogContent({
    required this.title,
    this.subTitle,
    this.showCelebrate = true,
    required this.iconAsset,
    this.additionalWidget,
    required this.additionalAsset,
  });

  final String title;
  final String? subTitle;
  final String iconAsset;
  final String additionalAsset;
  final Widget? additionalWidget;
  final bool showCelebrate;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        decoration: BoxDecoration(color: Co.white, borderRadius: BorderRadius.circular(32)),
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    if (showCelebrate)
                      // Decorative confetti background
                      VectorGraphicsWidget(additionalAsset, width: constraints.maxWidth, fit: BoxFit.cover)
                          .animate(
                            //onPlay: (controller) => controller.repeat(reverse: true),
                          )
                          .scale(duration: const Duration(seconds: 1)),
                    // Main success icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(26),
                          decoration: const BoxDecoration(color: Co.purple, shape: BoxShape.circle),
                          child: VectorGraphicsWidget(iconAsset, width: constraints.maxWidth * .35, fit: BoxFit.cover),
                        ),
                      ],
                    ),
                  ],
                ),
                const VerticalSpacing(8),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(title, textAlign: TextAlign.center, style: TStyle.robotBlackSubTitle()),
                      const VerticalSpacing(12),
                      if (subTitle != null) ...[
                        Text(
                          subTitle!,
                          textAlign: TextAlign.center,
                          style: context.style16400.copyWith(color: Co.darkGrey),
                        ),
                        const VerticalSpacing(20),
                      ],
                      if (additionalWidget != null) ...[additionalWidget!, const VerticalSpacing(12)],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
