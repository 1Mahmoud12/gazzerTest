import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/widgets/decoration_widgets/doubled_decorated_widget.dart';

class IncrementWidget extends StatefulWidget {
  const IncrementWidget({super.key, this.initVal = 1});
  final int initVal;
  @override
  State<IncrementWidget> createState() => _IncrementWidgetState();
}

class _IncrementWidgetState extends State<IncrementWidget> {
  late int val;

  @override
  void initState() {
    val = widget.initVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(
            borderRadius: AppConst.defaultBorderRadius,
            gradient: Grad.linearGradient,
            border: GradientBoxBorder(gradient: Grad.shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
          ),
          child: IconButton(
            onPressed: () {
              SystemSound.play(SystemSoundType.click);
              setState(() {
                val++;
              });
            },
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(5),
              elevation: 0,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(borderRadius: AppConst.defaultBorderRadius),
            ),
            icon: const Icon(Icons.add, color: Co.secondary, size: 22),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 40),
          child: Text("$val", style: TStyle.secondaryBold(16), textAlign: TextAlign.center),
        ),
        DoubledDecoratedWidget(
          innerDecoration: BoxDecoration(
            borderRadius: AppConst.defaultBorderRadius,
            gradient: Grad.linearGradient,
            border: GradientBoxBorder(gradient: Grad.shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white])),
          ),
          child: IconButton(
            onPressed: () {
              SystemSound.play(SystemSoundType.click);
              setState(() {
                if (val > 1) {
                  val--;
                }
              });
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
