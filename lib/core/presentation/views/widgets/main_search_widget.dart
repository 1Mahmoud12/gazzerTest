import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';

class MainSearchWidget extends StatefulWidget {
  const MainSearchWidget({
    super.key,
    this.controller,
    this.height = 50,
    this.borderRadius = 64,
    this.bgColor,
    this.hintText,
    this.prefix,
  });
  final TextEditingController? controller;
  final double height;
  final double borderRadius;
  final Color? bgColor;
  final String? hintText;
  final Widget? prefix;
  @override
  State<MainSearchWidget> createState() => _MainSearchWidgetState();
}

class _MainSearchWidgetState extends State<MainSearchWidget> {
  late final TextEditingController controller;

  @override
  void initState() {
    controller = widget.controller ?? TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainTextField(
      controller: controller,
      height: widget.height,
      borderRadius: widget.borderRadius,
      bgColor: widget.bgColor ?? Colors.transparent,
      hintText: widget.hintText,
      prefix: widget.prefix ?? const Icon(Icons.search, color: Co.purple, size: 32),
    );
  }
}
