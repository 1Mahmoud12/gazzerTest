import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class FilterItem extends StatefulWidget {
  const FilterItem({
    super.key,
    required this.isSelected,
    required this.title,
    required this.selectedTap,
    required this.type,
  });
  final bool isSelected;
  final String title;
  final Function(NotificationType) selectedTap;

  final NotificationType type;
  @override
  State<FilterItem> createState() => _FilterItemState();
}

class _FilterItemState extends State<FilterItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.selectedTap(widget.type);
      },
      child: Container(
        width: 100,
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: widget.isSelected ? Co.purple : Co.white,
          borderRadius: BorderRadius.circular(24),
          border: BoxBorder.all(color: Co.purple),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: TStyle.robotBlackRegular().copyWith(
              color: widget.isSelected ? Co.white : Co.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
