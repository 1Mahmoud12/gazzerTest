import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/switcher/switcher_item.dart';

/// Custom segmented control switcher widget
/// Displays a horizontal segmented control with rounded ends
/// Selected segment has darker purple background with white text
/// Unselected segments have light purple background with dark text
class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onChanged,
    this.height,
    this.padding = const EdgeInsets.all(8),
  });

  final List<SwitcherItem> items;
  final String selectedId;
  final ValueChanged<String> onChanged;
  final double? height;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: padding,
      decoration: BoxDecoration(color: Co.purple100, borderRadius: BorderRadius.circular(24)),
      child: Row(
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = item.id == selectedId;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(item.id),
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: isSelected ? Co.purple : Colors.transparent, borderRadius: BorderRadius.circular(24)),
                child: Center(
                  child: Text(
                    item.name,
                    style: TStyle.robotBlackMedium().copyWith(
                      color: isSelected ? Co.white : Co.greyText,
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
