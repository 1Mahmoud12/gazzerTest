import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';

class TutorialHeader extends StatefulWidget {
  const TutorialHeader({super.key});

  @override
  State<TutorialHeader> createState() => _TutorialHeaderState();
}

class _TutorialHeaderState extends State<TutorialHeader> {
  final controller = TextEditingController();
  final width = 550.0;
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: HomeUtils.headerHeight(context),
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          Positioned(
            bottom: 20,
            child: Transform.rotate(
              angle: -0.25,
              child: ClipOval(
                child: Container(
                  width: width * 1.2,
                  height: width,
                  decoration: BoxDecoration(
                    gradient: Grad().bglightLinear.copyWith(begin: Alignment.centerRight, colors: [Co.buttonGradient, Colors.black.withAlpha(0)]),
                  ),
                  // foregroundDecoration: BoxDecoration(gradient: Grad().linearGradient),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, -1),
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, MediaQuery.paddingOf(context).top, 16, 0),
              child: GradientTextWzShadow(
                text: L10n.tr().gazzerVideoTutorial,
                shadow: BoxShadow(color: Co.secondary.withAlpha(100), blurRadius: 8, offset: const Offset(0, 2)),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                gradient: Grad().textGradient,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
