import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';

class GradientRadioBtn extends StatelessWidget {
  const GradientRadioBtn({
    super.key,
    required this.isSelected,
    this.onPressed,
    this.size = 12,
  });
  final bool isSelected;
  final VoidCallback? onPressed;
  final double size;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(
          color: isSelected ? Co.purple : Co.lightGrey,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),

      child: AnimatedOpacity(
        opacity: isSelected ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: CircleAvatar(radius: size, backgroundColor: Co.purple),
        ),
      ),
    );
  }
}
