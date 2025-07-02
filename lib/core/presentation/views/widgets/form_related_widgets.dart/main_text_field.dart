import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/input_borders/gradient_outline_input_border.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/input_borders/gradient_underline_input_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';

export 'package:flutter/services.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    required this.controller,
    this.enabled = true,
    this.isLoading = false,
    this.hintText,
    this.label,
    this.style,
    this.onChange,
    this.onSubmitting,
    this.onSaved,
    this.validator,
    this.suffix,
    this.suffixWidget,
    this.prefix,
    this.height,
    this.width,
    this.isPassword = false,
    this.borderRadius,
    this.bgColor,
    this.isFilled = true,
    this.inputFormatters,
    this.padding,
    this.iconsConstraints,
    this.isValid,
    this.showShadow = true,
    this.maxLines,
    this.isOutLinedBorder = true,
    this.prefixOnTap,
    this.prefixColor,
    this.autofillHints,
  });
  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final TextStyle? style;
  final bool enabled;
  final bool isLoading;
  final Function(String)? onChange;
  final Function(String?)? onSubmitting;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final Widget? suffixWidget;
  final Widget? prefix;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool isPassword;
  final bool isFilled;
  final Color? bgColor;
  final TextInputFormatter? inputFormatters;
  final EdgeInsets? padding;
  final BoxConstraints? iconsConstraints;
  final bool? isValid;
  final bool showShadow;
  final int? maxLines;
  final bool isOutLinedBorder;
  final VoidCallback? prefixOnTap;
  final Color? prefixColor;
  final List<String>? autofillHints;
  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late ValueNotifier<bool> isObscure;
  late InputBorder focusedBorder;
  late InputBorder errorBorder;

  formBorders() {
    if (widget.isOutLinedBorder) {
      focusedBorder = GradientOutlineInputBorder(borderRadius: BorderRadius.circular((widget.borderRadius ?? 16)), gradient: Grad.shadowGrad(), width: 2);
    } else {
      focusedBorder = GradientUnderlineInputBorder(borderRadius: BorderRadius.circular((widget.borderRadius ?? 16)), gradient: Grad.shadowGrad(), width: 2);
    }
    errorBorder = GradientOutlineInputBorder(gradient: Grad.errorGradient, width: 1, borderRadius: BorderRadius.circular((widget.borderRadius ?? 16)));
  }

  @override
  void initState() {
    isObscure = ValueNotifier<bool>(widget.isPassword);
    formBorders();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant MainTextField oldWidget) {
    if (widget.isOutLinedBorder != oldWidget.isOutLinedBorder || widget.borderRadius != oldWidget.borderRadius) {
      setState(formBorders);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final iconContraints = widget.iconsConstraints ?? const BoxConstraints(minHeight: 25, maxHeight: 40, maxWidth: 40, minWidth: 25);
    return ValueListenableBuilder(
      valueListenable: isObscure,
      builder: (context, value, child) {
        return TextFormField(
          maxLines: widget.maxLines ?? 1,
          cursorColor: Co.purple,
          controller: widget.controller,
          enabled: widget.enabled,
          style: widget.style ?? TStyle.greySemi(14),
          validator: widget.validator,
          onChanged: widget.onChange,
          autofillHints: widget.autofillHints,
          onSaved: widget.onSaved,
          onFieldSubmitted: widget.onSubmitting,
          obscureText: value,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: TextInputAction.next,
          inputFormatters: widget.inputFormatters != null ? [widget.inputFormatters!] : null,
          keyboardType: widget.inputFormatters == FilteringTextInputFormatter.digitsOnly ? const TextInputType.numberWithOptions(signed: true) : null,
          decoration: InputDecoration(
            errorStyle: TStyle.errorSemi(13),
            errorMaxLines: widget.isPassword ? 4 : 1,
            contentPadding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            isDense: true,
            hintText: widget.hintText,
            hintStyle: widget.style ?? TStyle.greyRegular(12),
            labelStyle: TStyle.greySemi(15),
            labelText: widget.label,
            prefixIcon: widget.prefix == null
                ? null
                : Padding(
                    padding: EdgeInsets.only(right: L10n.isAr(context) ? 0 : 5, left: L10n.isAr(context) ? 5 : 0),
                    child: MaterialButton(
                      minWidth: 20,
                      onPressed: widget.prefixOnTap,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      shape: RoundedRectangleBorder(borderRadius: AppConst.defaultInnerBorderRadius),
                      color: widget.prefixColor,
                      child: widget.prefix,
                    ),
                  ),
            suffixIconConstraints: iconContraints,
            suffixIcon: Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: getSiffixIcon(value)),
            suffix: widget.suffixWidget,
            filled: widget.isFilled || widget.bgColor != null,
            fillColor: widget.bgColor ?? Co.white,
            focusedBorder: focusedBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            enabledBorder: focusedBorder,
            disabledBorder: focusedBorder,
          ),
        );
      },
    );
  }

  Widget? getSiffixIcon(value) {
    if (widget.suffix != null) return widget.suffix;
    if (widget.isLoading) return const AdaptiveProgressIndicator();
    if (widget.isPassword) {
      return InkWell(
        onTap: () => isObscure.value = !value,
        child: Icon(value ? CupertinoIcons.eye_slash_fill : CupertinoIcons.eye_fill, color: Co.dark, size: 20),
      );
    }
    return null;
  }
}
