import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/adaptive_progress_indicator.dart';

class OptionBtn extends StatelessWidget {
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
  Widget build(BuildContext context) {
    if (isLoading) {
      return AdaptiveProgressIndicator();
    }
    return Padding(
      padding: margin,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? AppConst.defaultRadius),
          boxShadow: !showBorder
              ? null
              : [
                  BoxShadow(
                    color: borderColor ?? Co.burble,
                    blurRadius: 0,
                    spreadRadius: 1,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
        ),
        child: MaterialButton(
          onPressed: !isEnabled ? null : onPressed,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius ?? AppConst.defaultRadius)),
          minWidth: width ?? (padding != null ? 10 : width ?? double.infinity),
          height: height ?? 50,

          elevation: 0,
          disabledElevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          highlightElevation: 0,
          color: !isEnabled ? disabledColor ?? (Co.greyText) : bgColor ?? Co.bg,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: child ?? Text(text ?? '', style: textStyle ?? TStyle.mainwSemi(15)),
          ),
        ),
      ),
    );
  }
}
