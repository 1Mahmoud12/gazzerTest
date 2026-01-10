import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';

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
    required this.onPressed,
    this.disabledColor,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.height,
    this.width,
    this.icon,
    this.child,
  });
  final String? text;
  final TextStyle? textStyle;
  final double? radius;
  final Color? bgColor;
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
  final Widget? child;
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
      return const Center(
        child: Padding(padding: EdgeInsets.all(2), child: AdaptiveProgressIndicator()),
      );
    }
    return Padding(
      padding: widget.margin,
      child: ValueListenableBuilder(
        valueListenable: isHovering,
        builder: (context, value, child) => DecoratedBox(
          decoration: BoxDecoration(
            border: widget.borderColor == null ? null : Border.all(color: widget.borderColor!, width: widget.borderThickness),
            color: widget.bgColor ?? Co.purple,
            borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
            // gradient: widget.bgColor != null
            //     ? null
            //     : value
            //     ? Grad().hoverGradient
            //     : Grad().radialGradient,
            boxShadow: [if (value) const BoxShadow(color: Co.darkMain, blurRadius: 0, spreadRadius: 0, offset: Offset(0, 0))],
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius),
              //gradient: widget.bgColor != null || value ? null : Grad().linearGradient,
            ),
            child: child,
          ),
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(widget.radius ?? AppConst.defaultInnerRadius)),
            padding: widget.padding ?? const EdgeInsets.all(6),
            elevation: 0,
            disabledBackgroundColor: widget.disabledColor,
            // minimumSize: Size(0, 0),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: Size(widget.width ?? (widget.padding == null ? double.infinity : 0), widget.padding != null ? 0 : widget.height ?? 50),
            backgroundColor: Colors.transparent,
          ),

          child: Padding(
            padding: widget.padding ?? EdgeInsets.zero,
            child: SizedBox(
              width: widget.width == null ? null : widget.width! - ((widget.padding?.horizontal ?? 0) * 2),
              child:
                  widget.child ??
                  Row(
                    spacing: 20,
                    mainAxisAlignment: widget.icon == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.icon is IconData || (widget.icon is String && widget.icon.endsWith('svg') == true))
                        DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: Grad().radialGradient,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Co.shadowColor.withAlpha(63), blurRadius: 4.1, spreadRadius: 1, offset: const Offset(0, 0))],
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(shape: BoxShape.circle, gradient: Grad().linearGradient),
                            child: Padding(
                              padding: const EdgeInsetsGeometry.all(12),
                              child: widget.icon is IconData
                                  ? Icon(widget.icon, size: (widget.height ?? 24) * 0.6, color: Co.white)
                                  : SvgPicture.asset(widget.icon!, height: widget.height ?? 24),
                            ),
                          ),
                        ),
                      Flexible(
                        child: FittedBox(
                          alignment: AlignmentDirectional.center,
                          fit: BoxFit.scaleDown,
                          child: Text(
                            widget.text ?? '',
                            style: widget.textStyle ?? context.style16400.copyWith(color: Co.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
