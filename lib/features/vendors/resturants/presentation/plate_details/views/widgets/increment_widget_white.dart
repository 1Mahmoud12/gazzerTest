import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class IncrementWidgetWhite extends StatelessWidget {
  const IncrementWidgetWhite({
    super.key,
    required this.initVal,
    required this.onChanged,
    required this.isAdding,
    required this.isRemoving,
    this.isIncrementDisabled = false,
    this.isDecrementDisabled = false,
    this.quantityInStock,
    this.onRemoving,
  });
  final int initVal;
  final Function({required bool isAdding}) onChanged;
  final Future<void> Function()? onRemoving;
  final bool isAdding;
  final bool isRemoving;
  final bool isIncrementDisabled;
  final bool isDecrementDisabled;
  final int? quantityInStock;

  bool get _hasReachedStockLimit {
    return quantityInStock != null && initVal >= quantityInStock!;
  }

  bool get _canIncrement {
    return !isIncrementDisabled && !_hasReachedStockLimit;
  }

  bool get canDecrement {
    return !isDecrementDisabled && initVal > 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: AppConst.defaultBorderRadius,
        border: Border.all(color: Co.purple100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _canIncrement
                ? () {
                    if (isAdding || isRemoving) return;
                    SystemSound.play(SystemSoundType.click);
                    onChanged(isAdding: true);
                  }
                : () {
                    if (_hasReachedStockLimit) {
                      Alerts.showToast(L10n.tr(context).max_quantity_reached_for_product);
                    }
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
                : Icon(Icons.add, color: _canIncrement ? Co.purple : Co.purple.withOpacityNew(0.4), size: 22),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 30),
            child: Text('$initVal', style: TStyle.robotBlackMedium(), textAlign: TextAlign.center),
          ),
          IconButton(
            onPressed: canDecrement
                ? () {
                    if (isAdding || isRemoving) return;
                    SystemSound.play(SystemSoundType.click);
                    onChanged(isAdding: false);
                  }
                : onRemoving != null
                ? () async {
                    await onRemoving!();
                  }
                : null,
            style: IconButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            ),
            icon: isRemoving
                ? const AdaptiveProgressIndicator(size: 22)
                : Icon(Icons.remove, color: canDecrement ? Co.black : Co.black.withOpacityNew(.3), size: 22),
          ),
        ],
      ),
    );
  }
}
