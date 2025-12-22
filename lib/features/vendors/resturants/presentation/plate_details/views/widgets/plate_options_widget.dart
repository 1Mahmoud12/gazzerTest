import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientRadioBtn, HorizontalSpacing, VerticalSpacing;
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';

class PlateOptionsWidget extends StatefulWidget {
  const PlateOptionsWidget({
    super.key,
    required this.optionId,
    required this.optionName,
    required this.values,
    required this.type,
    required this.selectedId,
    required this.getSelectedOptions,
    required this.onValueSelected,
  });

  final String optionId;
  final String optionName;
  final List<SubAddonEntity> values;
  final OptionType type;
  final Set<String> selectedId;
  final Function(String path) getSelectedOptions;
  final Function({required String fullPath, required String id}) onValueSelected;

  @override
  State<PlateOptionsWidget> createState() => _PlateOptionsWidgetState();
}

class _PlateOptionsWidgetState extends State<PlateOptionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        spacing: 6,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [..._buildValuesList(widget.values, 0, widget.optionId, widget.type)],
      ),
    );
  }

  List<Widget> _buildValuesList(List<SubAddonEntity> values, int level, [String parentPath = '', OptionType? parentType]) {
    return values.map((value) {
      final currentPath = parentPath.isEmpty ? value.id : '${parentPath}_${value.id}';

      // Determine the option key for checking selections
      String optionKey;
      if (parentPath.isEmpty) {
        // Top-level selection
        optionKey = widget.optionId;
      } else {
        // Nested selection - use the parent path as the option key
        optionKey = parentPath;
      }

      final isSelected = widget.getSelectedOptions(optionKey).contains(value.id);
      final hasSubAddons = value.subAddons.isNotEmpty;

      // Use parent's type if available, otherwise use widget's type
      final currentType = parentType ?? widget.type;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main value item
          InkWell(
            onTap: () {
              widget.onValueSelected(id: value.id, fullPath: currentPath);
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: 16 + (level * 20), // Indent based on level
                right: 16,
                top: 8,
                bottom: 8,
              ),
              child: AbsorbPointer(
                child: Row(
                  children: [
                    if (currentType == OptionType.checkbox)
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: isSelected,
                          visualDensity: VisualDensity.compact,
                          onChanged: (v) {},
                          side: BorderSide(color: isSelected ? Co.purple : Co.lightGrey, width: 2),
                        ),
                      )
                    else if (currentType == OptionType.radio)
                      GradientRadioBtn(isSelected: isSelected, size: 8),

                    const HorizontalSpacing(16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value.name, style: TStyle.robotBlackMedium()),
                          // Show price if not free, else show "مجاني" (free)
                          Text(value.isFree ? L10n.tr().free : '${Helpers.getProperPrice(value.price)} ', style: TStyle.robotBlackMedium()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Show sub-addons if this value is selected and has sub-addons
          if (isSelected && hasSubAddons) ...[
            const VerticalSpacing(8),
            Padding(
              padding: EdgeInsets.only(left: 16 + (level * 20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${L10n.tr().choose} ${value.name}', style: TStyle.blackBold(12).copyWith(color: Colors.grey[600])),
                  const VerticalSpacing(8),
                  ..._buildValuesList(value.subAddons, level + 1, currentPath, value.type),
                ],
              ),
            ),
          ],
        ],
      );
    }).toList();
  }
}
