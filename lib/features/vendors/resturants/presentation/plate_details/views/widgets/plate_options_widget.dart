import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/decorations.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientRadioBtn, HorizontalSpacing, VerticalSpacing;
import 'package:gazzer/features/vendors/common/domain/item_option_entity.dart';

class PlateOptionsWidget extends StatelessWidget {
  const PlateOptionsWidget({super.key, required this.option, required this.onValueSelected, required this.selectedId});
  final ItemOptionEntity option;
  final Set<int> selectedId;
  final Function(int id) onValueSelected;

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
            Text(option.name, style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow)),
            const VerticalSpacing(12),
            ...List.generate(option.values.length, (i) {
              final value = option.values[i];
              return InkWell(
                onTap: () => onValueSelected(value.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Row(
                      children: [
                        if (option.type == OptionType.checkbox)
                          Transform.scale(
                            scale: 1.1,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: selectedId.contains(value.id),
                              visualDensity: VisualDensity.compact,
                              onChanged: (v) {},
                            ),
                          )
                        else if (option.type == OptionType.radio)
                          GradientRadioBtn(isSelected: selectedId.contains(value.id), size: 8),

                        const HorizontalSpacing(24),
                        Text(value.name, style: TStyle.blackBold(14)),
                        const Spacer(),
                        Text(Helpers.getProperPrice(value.price), style: TStyle.blackBold(14)),
                      ],
                    ),
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
