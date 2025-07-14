part of '../single_restaurant_details.dart';

class _FoodDetailsWidget extends StatelessWidget {
  const _FoodDetailsWidget({required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        spacing: 12,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              GradientText(text: product.name, style: TStyle.blackBold(18)),
              const Spacer(),
              const DecoratedFavoriteWidget(size: 16),
              DoubledDecoratedWidget(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
                child: InkWell(
                  onTap: () {
                    SystemSound.play(SystemSoundType.click);
                    ;
                    AppNavigator().push(
                      AppTransitions().slideTransition(
                        AddFoodToCartScreen(product: product),
                        start: const Offset(0, 1),
                      ),
                      parent: Parent.main,
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.add, color: Co.second2, size: 20),
                  ),
                ),
              ),
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
          DecoratedBox(
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
                      text:
                          "lorem ipsum dolor sit amet, consectetur adipiscing elit. lorem ipsum dolor sit amet, consectetur adipiscing elit. lorem ipsum dolor sit amet, consectetur adipiscing elit.  ",
                      style: TStyle.blackSemi(14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
