import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/no_paste_formatter.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/utils/validators.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatefulWidget {
  const OtpWidget({
    super.key,
    required this.count,
    this.spacing,
    this.borderRadius,
    required this.controller,
    required this.width,
    required this.height,
  });
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
  late PinTheme defaultPinTheme;

  @override
  void initState() {
    defaultPinTheme = PinTheme(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: (widget.spacing ?? 32) * 0.5),
      textStyle: const TextStyle(
        fontSize: 20,
        color: Co.greyText,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Co.darkGrey, width: 1.5),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Form(
        child: Pinput(
          contextMenuBuilder: (context, editableTextState) {
            return AdaptiveTextSelectionToolbar(
              anchors: editableTextState.contextMenuAnchors,
              //  empty list or exclude paste action
              children: const [],
            );
          },
          controller: widget.controller,
          length: widget.count,
          defaultPinTheme: defaultPinTheme,
          focusedPinTheme: defaultPinTheme,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            NoPasteFormatter(),
          ],
          submittedPinTheme: defaultPinTheme,
          validator: (v) => Validators.valueMustBeNum(v, widget.count, 'Code'),
          // onCompleted: (pin) => print(pin),
        ),
      ),
    );
  }
}
