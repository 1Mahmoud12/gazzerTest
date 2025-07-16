import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({super.key, required this.count, this.spacing, this.borderRadius, required this.controller, required this.width, required this.height});
  final int count;
  final double? spacing;
  final double? borderRadius;
  final TextEditingController controller;
  final double width;
  final double height;

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  late final PinTheme defaultPinTheme;

  @override
  void initState() {
    defaultPinTheme = PinTheme(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: (widget.spacing ?? 32) * 0.5),
      textStyle: const TextStyle(fontSize: 20, color: Co.greyText, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 1),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 12),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: widget.controller,
        length: widget.count,
        closeKeyboardWhenCompleted: true,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: defaultPinTheme,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        submittedPinTheme: defaultPinTheme,
        validator: (v) => Validators.valueMustBeNum(v, widget.count, "Code"),
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

        // onSubmitted: (value) {},
        showCursor: true,
        // onCompleted: (pin) => print(pin),
      ),
    );
  }
}
