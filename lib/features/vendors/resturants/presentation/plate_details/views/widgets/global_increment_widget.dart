import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/switching_decorated_widget.dart';
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
  final Function(bool isAdding) onChanged;
  final bool isAdding;
  final bool isRemoving;
  final bool isHorizonal;
  final bool isDarkContainer;
  final double iconSize;
  final bool canAdd;

  @override
  Widget build(BuildContext context) {
    final children = [
      SwitchingDecoratedwidget(
        isDarkContainer: isDarkContainer,
        borderRadius: BorderRadius.circular(100),
        child: IconButton(
          onPressed: () {
            if (isAdding || isRemoving) return;
            SystemSound.play(SystemSoundType.click);
            onChanged(false);
          },
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(3),
            elevation: 0,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
          ),
          icon: isRemoving ? AdaptiveProgressIndicator(size: iconSize - 2, color: Co.secondary) : Icon(Icons.remove, color: Co.white, size: iconSize),
        ),
      ),

      ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 15),
        child: Text(
          '$initVal',
          style: TStyle.robotBlackSubTitle().copyWith(color: Co.secondary),
          textAlign: TextAlign.center,
        ),
      ),
      SwitchingDecoratedwidget(
        isDarkContainer: isDarkContainer,
        borderRadius: BorderRadius.circular(100),
        child: IconButton(
          onPressed: canAdd
              ? () {
                  if (isAdding || isRemoving) return;
                  SystemSound.play(SystemSoundType.click);
                  onChanged(true);
                }
              : () {
                  Alerts.showToast(L10n.tr(context).max_quantity_reached_for_product);
                },
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(3),
            elevation: 0,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
          ),
          icon: isAdding
              ? AdaptiveProgressIndicator(size: iconSize - 2, color: Co.secondary)
              : Icon(Icons.add, color: canAdd ? Co.white : Co.secondary.withOpacityNew(0.3), size: iconSize),
        ),
      ),
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: isHorizonal
          ? Row(
              spacing: 2,
              //mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [...children, const HorizontalSpacing(2)],
            )
          : Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.center, children: [...children]),
    );
  }
}
