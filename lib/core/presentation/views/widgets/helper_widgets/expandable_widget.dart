import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';

/// A reusable expandable widget that can be used anywhere in the app.
///
/// It consists of:
/// - Title section: icon (optional) + title text + arrow
/// - Body section: a Widget that is shown when expanded
class ExpandableWidget extends StatefulWidget {
  const ExpandableWidget({
    super.key,
    required this.title,
    required this.body,
    this.icon,
    this.titleWidget,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.titleStyle,
    this.iconColor,
    this.arrowColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
  });

  /// The title text to display
  final String title;

  /// Optional custom title widget (if provided, title text is ignored)
  final Widget? titleWidget;

  /// The widget to show when expanded
  final Widget body;

  /// Optional icon to show before the title
  final String? icon;

  /// Whether the widget is initially expanded
  final bool initiallyExpanded;

  /// Callback when expansion state changes
  final ValueChanged<bool>? onExpansionChanged;

  /// Style for the title text
  final TextStyle? titleStyle;

  /// Color for the icon
  final Color? iconColor;

  /// Color for the arrow icon
  final Color? arrowColor;

  /// Color for the border
  final Color? borderColor;

  /// Border radius for the container
  final BorderRadius? borderRadius;

  /// Padding for the title section
  final EdgeInsets? padding;

  @override
  State<ExpandableWidget> createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  @override
  void didUpdateWidget(ExpandableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initiallyExpanded != widget.initiallyExpanded) {
      _isExpanded = widget.initiallyExpanded;
    }
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title section - always visible
        InkWell(
          onTap: _toggleExpansion,
          borderRadius: widget.borderRadius ?? BorderRadius.circular(16),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(16),
            child: Row(
              children: [
                if (widget.icon != null) ...[SvgPicture.asset(widget.icon!), const HorizontalSpacing(12)],
                Expanded(
                  child: widget.titleWidget ?? Text(widget.title, style: widget.titleStyle ?? TStyle.robotBlackMedium().copyWith(color: Co.purple)),
                ),
                RotatedBox(
                  quarterTurns: _isExpanded ? 0 : 2,
                  child: SvgPicture.asset(Assets.arrowUp, colorFilter: ColorFilter.mode(widget.arrowColor ?? Co.purple, BlendMode.srcIn)),
                ),
              ],
            ),
          ),
        ),
        // Body section - shown when expanded
        if (_isExpanded) Padding(padding: widget.padding ?? const EdgeInsets.all(16), child: widget.body),
      ],
    );
  }
}
