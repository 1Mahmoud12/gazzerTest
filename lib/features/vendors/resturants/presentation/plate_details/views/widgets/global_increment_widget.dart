import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class GlobalIncrementWidget extends StatelessWidget {
  const GlobalIncrementWidget({
    super.key,
    required this.initVal,
    required this.onChanged,
    required this.isAdding,
    required this.isRemoving,
    required this.isHorizonal,
    required this.isDarkContainer,
    this.iconSize = 18,
    this.canAdd = true,
  });
  final int initVal;
  final Function({required bool isAdding}) onChanged;
  final bool isAdding;
  final bool isRemoving;
  final bool isHorizonal;
  final bool isDarkContainer;
  final double iconSize;
  final bool canAdd;

  @override
  Widget build(BuildContext context) {
    final children = [
      InkWell(
        onTap: () {
          if (isAdding || isRemoving) return;
          SystemSound.play(SystemSoundType.click);
          onChanged(isAdding: false);
        },

        child: isRemoving ? AdaptiveProgressIndicator(size: iconSize - 2, color: Co.secondary) : Icon(Icons.remove, color: Co.black, size: iconSize),
      ),

      ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 15),
        child: Text('$initVal', style: TStyle.robotBlackSubTitle(), textAlign: TextAlign.center),
      ),
      InkWell(
        onTap: canAdd
            ? () {
                if (isAdding || isRemoving) return;
                SystemSound.play(SystemSoundType.click);
                onChanged(isAdding: true);
              }
            : () {
                Alerts.showToast(L10n.tr(context).max_quantity_reached_for_product);
              },

        child: isAdding
            ? AdaptiveProgressIndicator(size: iconSize - 2, color: Co.secondary)
            : Icon(Icons.add, color: canAdd ? Co.purple : Co.secondary.withOpacityNew(0.3), size: iconSize),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: isHorizonal
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: AppConst.defaultBorderRadius,
                border: Border.all(color: Co.purple100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [...children],
              ),
            )
          : Column(mainAxisSize: MainAxisSize.min, children: [...children]),
    );
  }
}
