import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gazzer/core/domain/cart/cart_item_model.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import  'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/widgets/increment_widget_white.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key, required this.item});
  final CartItemModel item;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: AppConst.defaultPadding,
        child: SizedBox(
          height: 125,
          child: Row(
            children: [
              DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  border: GradientBoxBorder(gradient: Grad.shadowGrad(), width: 2),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(12), bottomLeft: Radius.circular(12)),
                  child: Image.asset(item.image, fit: BoxFit.cover, height: 125, width: 85),
                ),
              ),
              const HorizontalSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GradientText(text: item.name, style: TStyle.blackBold(16), textAlign: TextAlign.start),
                        ),
                        const Icon(Icons.star, color: Co.second2, size: 24),
                        const HorizontalSpacing(6),
                        Text(item.rate.toStringAsFixed(1), style: TStyle.blackSemi(13)),
                      ],
                    ),
                    const VerticalSpacing(4),
                    Text(
                      Helpers.getProperPrice(item.price),
                      style: TStyle.blackSemi(14).copyWith(shadows: AppDec.blackTextShadow),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const IncrementWidgetWhite(),
                        IconButton(
                          onPressed: () {
                            SystemSound.play(SystemSoundType.click);
                          },
                          icon: const Icon(CupertinoIcons.delete, color: Co.purple, size: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
