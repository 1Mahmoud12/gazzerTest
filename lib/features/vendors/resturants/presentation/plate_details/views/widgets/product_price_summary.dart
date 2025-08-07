import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show MainBtn, HorizontalSpacing;
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/increment_widget.dart';

class ProductPriceSummary extends StatelessWidget {
  const ProductPriceSummary({
    super.key,
    required this.onChangeQuantity,
    required this.price,
    required this.onsubmit,
    required this.quantity,
    required this.isLoading,
  });
  final Function(bool isAdding) onChangeQuantity;
  final double price;
  final int quantity;
  final Future Function() onsubmit;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
        gradient: Grad().radialGradient,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(36), topRight: Radius.circular(36)),
          gradient: Grad().linearGradient,
        ),
        child: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IncrementWidget(
                        initVal: quantity,
                        onChanged: onChangeQuantity,
                      ),
                    ),
                    Expanded(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: AppConst.defaultInnerBorderRadius,
                          border: GradientBoxBorder(
                            gradient: Grad().shadowGrad().copyWith(colors: [Co.white.withAlpha(0), Co.white]),
                            width: 2,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2),
                          child: MainBtn(
                            onPressed: () async {
                              await onsubmit();
                            },
                            isLoading: isLoading,
                            text: L10n.tr().addToCart,
                            textStyle: TStyle.secondaryBold(12),
                            bgColor: Colors.transparent,
                            height: 0,
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(L10n.tr().selectedType, style: TStyle.secondaryBold(13)),
                      ),
                    ),
                    const HorizontalSpacing(12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),

                        child: Row(
                          children: [
                            Text("${L10n.tr().total}:", style: TStyle.secondaryBold(13)),
                            const HorizontalSpacing(12),
                            Text(Helpers.getProperPrice(price), style: TStyle.secondaryBold(13)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
