import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class IncrementWidgetWhite extends StatelessWidget {
  const IncrementWidgetWhite({
    super.key,
    required this.initVal,
    required this.onChanged,
    required this.isAdding,
    required this.isRemoving,
  });
  final int initVal;
  final Function(bool isAdding) onChanged;
  final bool isAdding;
  final bool isRemoving;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: Grad().shadowGrad().copyWith(
                colors: [Colors.black26, Colors.black.withAlpha(0), Colors.black26],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              width: 2,
            ),
            borderRadius: AppConst.defaultBorderRadius,
          ),
          child: IconButton(
            onPressed: () {
              if (isAdding || isRemoving) return;
              SystemSound.play(SystemSoundType.click);
              onChanged(true);
            },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            ),
            icon: isAdding
                ? const AdaptiveProgressIndicator(size: 22)
                : const Icon(Icons.add, color: Co.secondary, size: 22),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 30),
          child: Text("$initVal", style: TStyle.secondaryBold(16), textAlign: TextAlign.center),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: Grad().shadowGrad().copyWith(
                colors: [Colors.black26, Colors.black.withAlpha(0), Colors.black26],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              width: 2,
            ),
            borderRadius: AppConst.defaultBorderRadius,
          ),
          child: IconButton(
            onPressed: () {
              if (isAdding || isRemoving) return;
              SystemSound.play(SystemSoundType.click);
              onChanged(false);
            },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            ),
            icon: isRemoving
                ? const AdaptiveProgressIndicator(size: 22)
                : const Icon(Icons.remove, color: Co.secondary, size: 22),
          ),
        ),
      ],
    );
  }
}
