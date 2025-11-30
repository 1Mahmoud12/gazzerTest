import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';

class IncrementWidget extends StatelessWidget {
  const IncrementWidget({
    super.key,
    this.initVal = 1,
    required this.onChanged,
    this.isIncrementDisabled = false,
  });
  final int initVal;
  final Function(bool isAdding) onChanged;
  final bool isIncrementDisabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(
            borderRadius: AppConst.defaultBorderRadius,
            gradient: Grad().linearGradient,
            border: GradientBoxBorder(gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
          ),
          child: IconButton(
            onPressed: isIncrementDisabled
                ? () {
                    Alerts.showToast(L10n.tr().maximumQuantityReached);
                  }
                : () {
                    SystemSound.play(SystemSoundType.click);
                    onChanged(true);
                  },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(5),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            ),
            icon: Icon(
              Icons.add,
              color: isIncrementDisabled ? Co.secondary.withOpacity(0.4) : Co.secondary,
              size: 22,
            ),
          ),
        ),
        if (initVal != 0)
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 40),
            child: Text("$initVal", style: TStyle.secondaryBold(16), textAlign: TextAlign.center),
          ),
        if (initVal != 0)
          DoubledDecoratedWidget(
            innerDecoration: BoxDecoration(
              borderRadius: AppConst.defaultBorderRadius,
              gradient: Grad().linearGradient,
              border: GradientBoxBorder(gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
            ),
            child: IconButton(
              onPressed: () {
                SystemSound.play(SystemSoundType.click);
                if (initVal > 1) {
                  onChanged(false);
                }
              },
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(5),
                elevation: 0,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
              ),
              icon: const Icon(Icons.remove, color: Co.secondary, size: 20),
            ),
          ),
      ],
    );
  }
}
