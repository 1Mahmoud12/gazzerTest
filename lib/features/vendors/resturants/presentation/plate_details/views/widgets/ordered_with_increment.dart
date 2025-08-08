import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/doubled_decorated_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';

class OrderedWithIncrement extends StatelessWidget {
  const OrderedWithIncrement({
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:  4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DoubledDecoratedWidget(
            child: IconButton(
              onPressed: () {
                if (isAdding || isRemoving) return;
                SystemSound.play(SystemSoundType.click);
                onChanged(true);
              },
              style: IconButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                elevation: 0,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
              ),
              icon: isAdding
                  ? const AdaptiveProgressIndicator(size: 18, color: Co.secondary)
                  : const Icon(Icons.add, color: Co.secondary, size: 18),
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 15),
            child: Text("$initVal", style: TStyle.secondarySemi(13), textAlign: TextAlign.center),
          ),
          DoubledDecoratedWidget(
            child: IconButton(
              onPressed: () {
                if (isAdding || isRemoving) return;
                SystemSound.play(SystemSoundType.click);
                onChanged(false);
              },
              style: IconButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                elevation: 0,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
              ),
              icon: isRemoving
                  ? const AdaptiveProgressIndicator(size: 18, color: Co.secondary)
                  : const Icon(Icons.remove, color: Co.secondary, size: 18),
            ),
          ),
          HorizontalSpacing(2),
        ],
      ),
    );
  }
}
