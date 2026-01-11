import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

/// A generic dropdown widget that displays a list of items and allows selection
/// Similar to PopupMenuButton but with custom styling
class CustomDropdown<T> extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.itemBuilder,
    required this.selectedItemBuilder,
    this.padding,
    this.width,
    this.borderColor,
    this.fillColor,
    this.borderRadius,
    this.showDropDownIcon = true,
    this.directionArrowButton,
    this.menuItemPadding,
    this.buttonPadding,
    this.menuMaxHeight,
    this.maxWidth = true,
    this.addSpacer = true,
    this.enabled = true,
    this.onTap,
    this.iconColor,
  });

  /// List of items to display in the dropdown
  final List<T> items;

  /// Currently selected item
  final T selectedItem;

  /// Callback when an item is selected
  final ValueChanged<T> onChanged;

  /// Builder for each item in the dropdown menu
  final Widget Function(BuildContext context, T item) itemBuilder;

  /// Builder for the selected item display (the button/trigger)
  final Widget Function(BuildContext context, T item) selectedItemBuilder;

  /// Padding around the dropdown trigger
  final EdgeInsets? padding;

  /// Width of the dropdown button
  final double? width;

  /// Border color of the dropdown button
  final Color? borderColor;

  /// Fill color of the dropdown button
  final Color? fillColor;

  /// Icon color of the dropdown button
  final Color? iconColor;

  /// Border radius of the dropdown button
  final double? borderRadius;

  /// Whether to show the dropdown arrow icon
  final bool showDropDownIcon;

  /// Direction of arrow button (0 = down, 2 = up, etc.)
  final int? directionArrowButton;

  /// Padding for menu items
  final EdgeInsets? menuItemPadding;

  /// Padding for the button
  final EdgeInsetsGeometry? buttonPadding;

  /// Maximum height of the menu
  final double? menuMaxHeight;

  /// Whether menu should take max width
  final bool maxWidth;

  /// Whether to add spacer between content and arrow
  final bool addSpacer;

  /// Whether the dropdown is enabled
  final bool enabled;

  /// Optional tap callback (if provided, dropdown won't open)
  final VoidCallback? onTap;

  @override
  State<CustomDropdown<T>> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  late T _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedItem;
    developer.log(
      'CustomDropdown initialized with selected item: $_selectedItem',
    );
  }

  @override
  void didUpdateWidget(CustomDropdown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedItem != widget.selectedItem) {
      _selectedItem = widget.selectedItem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        padding:
            widget.buttonPadding ??
            widget.padding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 24),
          color: widget.fillColor ?? Co.white,
          border: Border.all(color: widget.borderColor ?? Co.lightPurple),
        ),
        child: PopupMenuButton<T>(
          color: context.isDarkMode ? Co.darkModeLayer : Co.white,

          elevation: 4,
          enabled: widget.enabled && widget.onTap == null,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          constraints: BoxConstraints(
            maxHeight: widget.menuMaxHeight ?? double.infinity,
            minWidth: screenWidth * 0.3,
            maxWidth: widget.width != null
                ? widget.width!
                : widget.maxWidth
                ? screenWidth * 0.9
                : screenWidth * 0.3,
          ),
          position: PopupMenuPosition.under,
          offset: const Offset(0, 8),
          onSelected: (T selectedValue) {
            setState(() {
              _selectedItem = selectedValue;
            });
            widget.onChanged(selectedValue);
          },
          itemBuilder: (BuildContext context) {
            return widget.items.map((T item) {
              return PopupMenuItem<T>(
                value: item,
                padding:
                    widget.menuItemPadding ?? const EdgeInsets.only(left: 10.0),
                child: Container(
                  alignment: widget.maxWidth
                      ? AlignmentDirectional.centerStart
                      : AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withAlpha((0.2 * 255).toInt()),
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 12,
                  ),
                  width: widget.maxWidth
                      ? screenWidth * 0.9
                      : screenWidth * 0.3,
                  child: widget.itemBuilder(context, item),
                ),
              );
            }).toList();
          },
          popUpAnimationStyle: const AnimationStyle(
            curve: Curves.linear,
            duration: Duration(milliseconds: 400),
          ),
          child: Row(
            children: [
              Expanded(
                child: widget.selectedItemBuilder(context, _selectedItem),
              ),
              if (widget.addSpacer) const Spacer(),
              if (widget.showDropDownIcon)
                RotatedBox(
                  quarterTurns: widget.directionArrowButton ?? 0,
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: widget.iconColor ?? Co.black,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
