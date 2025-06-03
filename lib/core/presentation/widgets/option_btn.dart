import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/widgets/main_text_field.dart';

class OptionBtn extends StatefulWidget {
  OptionBtn({
    super.key,
    this.text,
    this.child,
    this.textStyle,
    this.radius,
    this.bgColor,
    this.borderColor,
    this.isLoading = false,
    this.isEnabled = true,
    this.borderThickness = 1.0,
    this.showBorder = true,
    required this.onPressed,
    this.disabledColor,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.height,
    this.width,
  }) {
    assert(text != null || child != null, 'Either text or child must be provided');
  }
  final String? text;
  final Widget? child;
  final TextStyle? textStyle;
  final double? radius;
  final Color? bgColor;
  final bool showBorder;
  final Color? borderColor;
  final Color? disabledColor;
  final bool isLoading;
  final bool isEnabled;
  final double borderThickness;
  final EdgeInsets? padding;
  final EdgeInsets margin;
  final double? height;
  final double? width;
  final Function() onPressed;

  @override
  State<OptionBtn> createState() => _OptionBtnState();
}

class _OptionBtnState extends State<OptionBtn> {
  final isHovering = ValueNotifier<bool>(false);

  @override
  void dispose() {
    isHovering.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return AdaptiveProgressIndicator();
    }
    return Padding(
      padding: widget.margin,
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (context, value, child) => DecoratedBox(
          decoration: BoxDecoration(
            gradient: value ? Grad.hoverGradient : null,
            borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
            color: value ? null : widget.bgColor ?? Co.bg,
            border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 2),
          ),
          child: child!,
        ),
        child: FilledButton(
          onPressed: !widget.isEnabled
              ? null
              : () {
                  SystemSound.play(SystemSoundType.click);
                  widget.onPressed();
                },
          onHover: (value) {
            isHovering.value = value;
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
            ),
            minimumSize: Size(
              widget.width ?? (widget.padding != null ? 10 : widget.width ?? double.infinity),
              widget.height ?? 60,
            ),
            elevation: 0,
            padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            backgroundColor: Colors.transparent,
          ),

          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: widget.child ?? Text(widget.text ?? '', style: widget.textStyle ?? TStyle.mainwSemi(15)),
          ),
        ),
      ),
    );
  }
}
