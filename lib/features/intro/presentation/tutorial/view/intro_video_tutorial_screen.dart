import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/widgets/tutorial_bottom_sheet.dart';

class IntroVideoTutorialScreen extends StatefulWidget {
  const IntroVideoTutorialScreen({super.key, required this.videoLink});
  final String videoLink;
  @override
  State<IntroVideoTutorialScreen> createState() => _IntroVideoTutorialScreenState();
}

class _IntroVideoTutorialScreenState extends State<IntroVideoTutorialScreen> {
  final isHovering = ValueNotifier<bool>(false);
  bool isNextPPressed = false;

  @override
  void dispose() {
    isHovering.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox.expand(
            child: AnimatedCrossFade(
              duration: Durations.extralong1,

              secondChild: Image.asset(Assets.assetsPngVideoTutorialPlaceholder2, fit: BoxFit.cover),
              firstChild: Image.asset(Assets.assetsPngVideotutorialVideoPlaceholder, fit: BoxFit.cover),
              crossFadeState: isNextPPressed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            ),
          ),
          Align(
            alignment: const Alignment(0.9, 0.75),
            child: ValueListenableBuilder(
              valueListenable: isHovering,
              builder: (context, value, child) {
                if (value) {
                  return child!;
                } else {
                  return DoubledDecoratedWidget(borderRadius: BorderRadius.circular(100), child: child!);
                }
              },
              child: InkWell(
                onTap: () {
                  setState(() => isNextPPressed = !isNextPPressed);
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    barrierColor: Co.bg.withAlpha(125),
                    // shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
                    builder: (context) {
                      return const TutorialBottomSheet();
                    },
                  ).then((_) {
                    if (mounted) {
                      setState(() => isNextPPressed = !isNextPPressed);
                    }
                  });
                },
                onHover: (value) {
                  isHovering.value = value;
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios, color: Co.bg, size: 32),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
