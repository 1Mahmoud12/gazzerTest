import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';

class OptionBtn extends StatefulWidget {
  const OptionBtn({
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
    this.textAlign = TextAlign.start,
    this.width,
  }) : assert(text != null || child != null, 'Either text or child must be provided');

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
  final TextAlign textAlign;
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
      return const Center(child: AdaptiveProgressIndicator());
    }
    return Padding(
      padding: widget.margin,
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (context, value, child) => DecoratedBox(
          decoration: BoxDecoration(
            gradient: value ? Grad().hoverGradient : null,
            borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
            color: value ? null : widget.bgColor ?? Colors.transparent,
            border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2),
          ),
          child: child,
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
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius)),
            minimumSize: Size(widget.width ?? (widget.padding != null ? 10 : widget.width ?? double.infinity), widget.height ?? 54),
            elevation: 0,
            padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            backgroundColor: Colors.transparent,
          ),

          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child:
                widget.child ??
                Text(
                  widget.text ?? '',
                  style: widget.textStyle ?? TStyle.robotBlackMedium().copyWith(color: Co.purple),
                  textAlign: widget.textAlign,
                ),
          ),
        ),
      ),
    );
  }
}
