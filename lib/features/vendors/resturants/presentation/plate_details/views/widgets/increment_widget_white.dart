import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

class IncrementWidgetWhite extends StatelessWidget {
  const IncrementWidgetWhite({super.key, this.initVal = 1, required this.onChanged, required this.isLoading});
  final int initVal;
  final Function(bool isAdding) onChanged;
  final bool isLoading;
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
            icon: const Icon(Icons.add, color: Co.secondary, size: 22),
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
            icon: const Icon(Icons.remove, color: Co.secondary, size: 22),
          ),
        ),
      ],
    );
  }
}
