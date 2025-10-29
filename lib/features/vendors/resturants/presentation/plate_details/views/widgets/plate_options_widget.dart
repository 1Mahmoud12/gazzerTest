import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/decorations.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
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
    return DecoratedBox(
      decoration: BoxDecoration(
        border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2),
      ),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.optionName,
              style: TStyle.blackBold(
                14,
              ).copyWith(shadows: AppDec.blackTextShadow),
            ),
            const VerticalSpacing(12),
            ..._buildValuesList(widget.values, 0, widget.optionId, widget.type),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildValuesList(
    List<SubAddonEntity> values,
    int level, [
    String parentPath = '',
    OptionType? parentType,
  ]) {
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
                absorbing: true,
                child: Row(
                  children: [
                    if (currentType == OptionType.checkbox)
                      Transform.scale(
                        scale: 1.1,
                        child: Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          value: isSelected,
                          visualDensity: VisualDensity.compact,
                          onChanged: (v) {},
                        ),
                      )
                    else if (currentType == OptionType.radio)
                      GradientRadioBtn(
                        isSelected: isSelected,
                        size: 8,
                      ),

                    const HorizontalSpacing(24),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(value.name, style: TStyle.blackRegular(14)),
                          // Show price if not free, else show "مجاني" (free)
                          Text(
                            value.isFree ? 'مجاني' : '${value.price} جنيه',
                            style: TStyle.blackRegular(12).copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
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
                  Text(
                    '${L10n.tr().choose} ${value.name}',
                    style: TStyle.blackBold(12).copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const VerticalSpacing(8),
                  ..._buildValuesList(
                    value.subAddons,
                    level + 1,
                    currentPath,
                    value.type,
                  ),
                ],
              ),
            ),
          ],
        ],
      );
    }).toList();
  }
}
