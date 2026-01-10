import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';

class IncrementWidget extends StatelessWidget {
  const IncrementWidget({super.key, this.initVal = 1, required this.onChanged, this.isIncrementDisabled = false});
  final int initVal;
  final Function(bool isAdding) onChanged;
  final bool isIncrementDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: AppConst.defaultInnerBorderRadius,
        border: Border.all(color: Co.black.withOpacityNew(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: isIncrementDisabled
                  ? () {
                      Alerts.showToast(L10n.tr().maximumQuantityReached);
                    }
                  : () {
                      SystemSound.play(SystemSoundType.click);
                      onChanged(true);
                    },
              child: Icon(Icons.add, color: isIncrementDisabled ? Co.black.withOpacityNew(0.4) : Co.black, size: 22),
            ),
          ),
          if (initVal != 0)
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 40),
              child: Text('$initVal', style: context.style20500, textAlign: TextAlign.center),
            ),
          if (initVal != 0)
            Expanded(
              child: InkWell(
                onTap: () {
                  SystemSound.play(SystemSoundType.click);
                  if (initVal > 1) {
                    onChanged(false);
                  }
                },
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                child: const Icon(Icons.remove, color: Co.black),
              ),
            ),
        ],
      ),
    );
  }
}
