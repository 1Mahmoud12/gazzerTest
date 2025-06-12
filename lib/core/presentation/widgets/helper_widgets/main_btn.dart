import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/widgets/helper_widgets/adaptive_progress_indicator.dart';

class MainBtn extends StatefulWidget {
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
  State<MainBtn> createState() => _MainBtnState();
}

class _MainBtnState extends State<MainBtn> {
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
      padding: widget.margin,
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (context, value, child) => DecoratedBox(
          decoration: BoxDecoration(
            color: widget.bgColor,
            borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
            gradient: widget.bgColor != null
                ? null
                : value
                ? Grad.hoverGradient
                : Grad.radialGradient,
            boxShadow: value
                ? []
                : [const BoxShadow(color: Co.darkMain, blurRadius: 0, spreadRadius: 0, offset: Offset(0, 0))],
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
          onHover: (v) {
            isHovering.value = v;
          },
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
            ),
            padding: widget.padding ?? const EdgeInsets.all(6),
            elevation: 0,
            // minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size(
              widget.width ?? (widget.padding == null ? double.infinity : 0),
              widget.padding != null ? 0 : widget.height ?? 50,
            ),
            backgroundColor: Colors.transparent,
          ),

          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: SizedBox(
              width: widget.width == null ? null : widget.width! - ((widget.padding?.horizontal ?? 0) * 2),
              child: Row(
                spacing: 20,
                mainAxisAlignment: widget.icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon is IconData || (widget.icon is String && widget.icon.endsWith('svg') == true))
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: Grad.radialGradient,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Co.shadowColor.withAlpha(80),
                            blurRadius: 4,
                            spreadRadius: 1,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsetsGeometry.all(4),
                        child: widget.icon is IconData
                            ? Icon(widget.icon!, size: (widget.height ?? 32) * 0.6, color: Co.white)
                            : SvgPicture.asset(widget.icon!, height: widget.height ?? 32),
                      ),
                    ),
                  Text(widget.text ?? '', style: widget.textStyle ?? TStyle.whiteSemi(14)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
