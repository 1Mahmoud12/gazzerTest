import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_radio_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';

class LabelItem extends StatelessWidget {
  const LabelItem({super.key, required this.title, required this.onSelect, required this.isSelected});
  final String title;
  final bool isSelected;
  final Function() onSelect;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppConst.defaultBorderRadius,
      onTap: onSelect,
      child: ColoredBox(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GradientRadioBtn(isSelected: isSelected, size: 8),
              const HorizontalSpacing(12),
              Text(title, style: TStyle.robotBlackMedium()),
            ],
          ),
        ),
      ),
    );
  }
}
