import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({super.key, required this.count, this.spacing, this.borderRadius, required this.controller, required this.width, required this.height});
  final int count;
  final double? spacing;
  final double? borderRadius;
  final TextEditingController controller;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: (spacing ?? 32) * 0.5),
      textStyle: const TextStyle(fontSize: 20, color: Co.greyText, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 1),
        borderRadius: BorderRadius.circular(borderRadius ?? 12),
      ),
    );

    return Pinput(
      controller: controller,
      length: count,
      closeKeyboardWhenCompleted: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme,
      submittedPinTheme: defaultPinTheme,
      validator: (v) => Validators.valueMustBeNum(v, count, "Code"),
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

      // onSubmitted: (value) {},
      showCursor: true,
      // onCompleted: (pin) => print(pin),
    );
  }
}
