import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_gradient.dart';
import 'package:gazzer/core/presentation/theme/decorations.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientRadioBtn, HorizontalSpacing, VerticalSpacing;

class ProductTypesWidget extends StatefulWidget {
  const ProductTypesWidget({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductTypesWidget> createState() => _ProductTypesWidgetState();
}

class _ProductTypesWidgetState extends State<ProductTypesWidget> {
  int _selectedIndex = -1;
  final items = ["Mayionez", "Ketchup", "Mustard"];
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2)),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: Column(
          spacing: 6,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(L10n.tr().selectType, style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow)),
            const VerticalSpacing(12),
            ...List.generate(
              items.length,
              (i) => InkWell(
                onTap: () {
                  setState(() {
                    _selectedIndex = i;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    children: [
                      GradientRadioBtn(isSelected: i == _selectedIndex, size: 8),
                      const HorizontalSpacing(24),
                      Text(items[i], style: TStyle.blackBold(14)),
                      const Spacer(),
                      Text(Helpers.getProperPrice((i + 1) * 7.5), style: TStyle.blackBold(14)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
