part of '../single_cat_restaurant_details.dart';

class _FoodDetailsWidget extends StatelessWidget {
  const _FoodDetailsWidget({required this.product});
  final GenericItemEntity product;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Expanded(
              child: GradientText(textAlign: TextAlign.start, text: product.name, style: TStyle.blackBold(18)),
            ),
            DecoratedFavoriteWidget(size: 16, fovorable: product),
            // AddIcon(
            //   onTap: () {
            //     SystemSound.play(SystemSoundType.click);
            //     AddFoodToCartRoute($extra: product).push(context);
            //   },
            //   padding: const EdgeInsets.all(6),
            // ),
          ],
        ),
        Row(
          children: [
            GradientTextWzShadow(
              text: Helpers.getProperPrice(product.price),
              shadow: AppDec.blackTextShadow.first,
              style: TStyle.blackSemi(14),
            ),
            const HorizontalSpacing(32),
            const Icon(Icons.star, color: Co.secondary, size: 20),
            Text(product.rate.toStringAsFixed(1), style: TStyle.secondaryBold(14)),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(border: GradientBoxBorder(gradient: Grad().shadowGrad(), width: 2)),
            child: Padding(
              padding: AppConst.defaultPadding,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: L10n.tr().details,
                      style: TStyle.blackBold(14).copyWith(shadows: AppDec.blackTextShadow),
                    ),
                    const TextSpan(text: "\n"),
                    const WidgetSpan(child: VerticalSpacing(24)),
                    TextSpan(
                      text: product.description,
                      style: TStyle.blackSemi(14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
