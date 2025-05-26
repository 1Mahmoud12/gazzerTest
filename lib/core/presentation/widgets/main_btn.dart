import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/constants.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/adaptive_progress_indicator.dart';

class MainBtn extends StatelessWidget {
  const MainBtn({
    super.key,
    this.text,
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
    this.icon,
  });
  final String? text;
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
  final dynamic icon;

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
          gradient: LinearGradient(colors: [Co.darkMain, Co.main], begin: Alignment.bottomRight, end: Alignment.topLeft),
          boxShadow: [BoxShadow(color: Co.darkMain, blurRadius: 0, spreadRadius: 0, offset: const Offset(0, 0))],
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
          color: Colors.transparent,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Padding(
            padding: padding ?? EdgeInsets.zero,
            child: Row(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon is IconData || (icon is String && icon.endsWith('svg') == true))
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Co.main, Co.darkMain]),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.white60, blurRadius: 4, spreadRadius: 2)],
                    ),
                    child: Padding(
                      padding: EdgeInsetsGeometry.all((height ?? 50) * 0.1),
                      child: icon is IconData ? Icon(icon!, size: (height ?? 50) * 0.6, color: Co.white) : SvgPicture.asset(icon!, height: height ?? 40),
                    ),
                  ),
                Text(text ?? '', style: textStyle ?? TStyle.whiteSemi(15)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
