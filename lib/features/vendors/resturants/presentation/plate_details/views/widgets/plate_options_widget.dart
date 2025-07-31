import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/extensions/irretable.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/decorations.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientRadioBtn, HorizontalSpacing, VerticalSpacing;
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class PlateOptionsWidget extends StatefulWidget {
  const PlateOptionsWidget({super.key, required this.option, required this.onSelection});
  final PlateOptionEntity option;
  final bool Function(Set<int> ids) onSelection;

  @override
  State<PlateOptionsWidget> createState() => _PlateOptionsWidgetState();
}

class _PlateOptionsWidgetState extends State<PlateOptionsWidget> {
  final Set<int> selectedId = {};

  void checkboxToggle(int id) {
    setState(() {
      if (selectedId.add(id) != true) selectedId.remove(id);
    });
  }

  void radioSelect(int id) {
    selectedId.clear();
    setState(() {
      selectedId.add(id);
    });
  }

  @override
  void initState() {
    final defaultId = widget.option.values.firstWhereOrNull((e) => e.isDefault == true)?.id;
    if (defaultId != null) selectedId.add(defaultId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2)),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.option.name, style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow)),
            const VerticalSpacing(12),
            ...List.generate(widget.option.values.length, (i) {
              final value = widget.option.values[i];
              return InkWell(
                onTap: () {
                  if (widget.option.type == OptionType.radio) {
                    radioSelect(value.id);
                  } else {
                    checkboxToggle(value.id);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      if (widget.option.type == OptionType.checkbox)
                        Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: selectedId.contains(value.id),
                            visualDensity: VisualDensity.compact,
                            onChanged: (val) {
                              checkboxToggle(value.id);
                            },
                          ),
                        )
                      else if (widget.option.type == OptionType.radio)
                        GradientRadioBtn(isSelected: selectedId.contains(value.id), size: 8),

                      const HorizontalSpacing(24),
                      Text(value.name, style: TStyle.blackBold(14)),
                      const Spacer(),
                      Text(Helpers.getProperPrice((i + 1) * 7.5), style: TStyle.blackBold(14)),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
