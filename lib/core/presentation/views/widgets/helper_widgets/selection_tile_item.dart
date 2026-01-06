import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';

class SelectionTileItem extends StatelessWidget {
  const SelectionTileItem({
    super.key,
    required this.isSelected,
    this.title,
    this.child,
    this.titleStyle,
    required this.onTap,
    this.radioSize,
    this.spacing,
    required this.isSingle,
  });
  final bool isSelected;
  final String? title;
  final Widget? child;
  final TextStyle? titleStyle;
  final VoidCallback onTap;
  final double? radioSize;
  final double? spacing;
  final bool isSingle;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: spacing ?? 8,
          children: [
            if (isSingle)
              GradientRadioBtn(isSelected: isSelected, onPressed: onTap, size: radioSize ?? 12)
            else
              Transform.scale(
                scale: (radioSize ?? 12) / 12,
                child: Checkbox(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: isSelected,
                  visualDensity: VisualDensity.compact,
                  onChanged: (val) {
                    onTap();
                  },
                ),
              ),

            if (title != null) Text(title!, style: titleStyle ?? TStyle.robotBlackRegular14()) else ?child,
          ],
        ),
      ),
    );
  }
}
