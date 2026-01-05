import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';

class PlanAnimatedBtn extends StatefulWidget {
  const PlanAnimatedBtn({
    super.key,
    this.text,
    required this.onPressed,
    this.isLoading = false,
    required this.isAnimating,
    required this.animDuration,
    this.child,
    this.textStyle,
  }) : assert(text != null || child != null, 'Either text or child must be provided');
  final bool isLoading;
  final ValueNotifier<bool> isAnimating;
  final Duration animDuration;
  final String? text;
  final Widget? child;
  final TextStyle? textStyle;
  final Function() onPressed;

  @override
  State<PlanAnimatedBtn> createState() => _PlanAnimatedBtnState();
}

class _PlanAnimatedBtnState extends State<PlanAnimatedBtn> {
  final isHovering = ValueNotifier<bool>(false);

  @override
  void dispose() {
    isHovering.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return const AdaptiveProgressIndicator();
    }
    return Padding(
      padding: EdgeInsets.zero,
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (context, value, child) => DecoratedBox(
          decoration: BoxDecoration(
            gradient: value ? Grad().hoverGradient : null,
            borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius),
            color: value ? null : Colors.transparent,
            border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2),
          ),
          child: child!,
        ),
        child: FilledButton(
          onPressed: () {
            SystemSound.play(SystemSoundType.click);
            widget.onPressed();
          },
          onHover: (value) {
            isHovering.value = value;
          },
          style: FilledButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConst.defaultInnerRadius)),
            minimumSize: const Size(209, 60),
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            backgroundColor: Colors.transparent,
          ),

          child: ValueListenableBuilder(
            valueListenable: widget.isAnimating,
            builder: (context, value, child) => AnimatedOpacity(
              duration: widget.animDuration,
              curve: Curves.easeInOut,
              opacity: value ? 1 : 0,
              child: AnimatedSlide(
                duration: widget.animDuration,
                curve: Curves.easeInOut,
                offset: value ? Offset.zero : const Offset(-1, 0),
                child: child,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.zero,
              child:
                  widget.child ??
                  Text(
                    widget.text ?? '',
                    style: widget.textStyle ?? TStyle.robotBlackMedium().copyWith(color: Co.purple),
                    textAlign: TextAlign.start,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
