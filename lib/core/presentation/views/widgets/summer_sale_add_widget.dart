import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/animations/animated_discount_percentage_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/decoration_widgets/spiky_shape_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';

class SummerSaleAddWidget extends StatefulWidget {
  const SummerSaleAddWidget({super.key});

  @override
  State<SummerSaleAddWidget> createState() => _SummerSaleAddWidgetState();
}

class _SummerSaleAddWidgetState extends State<SummerSaleAddWidget> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return SpikyShapeWidget(
      color: const Color(0x66FFC4C4),
      ltChild: const Expanded(flex: 2, child: AnimatedDiscountPercentageWidget()),
      rtChild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GradientText(text: L10n.tr().megaSummerSale, style: TStyle.blackBold(20), gradient: Grad().radialGradient),

          Text(L10n.tr().dealsStarts27May, style: TStyle.blackBold(14)),
        ],
      ),
    );
  }
}
