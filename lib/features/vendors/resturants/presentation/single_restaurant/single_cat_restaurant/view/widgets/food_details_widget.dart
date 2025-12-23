part of '../single_cat_restaurant_details.dart';

class _FoodDetailsWidget extends StatelessWidget {
  const _FoodDetailsWidget({required this.product});
  final GenericItemEntity product;
  @override
  Widget build(BuildContext context) {
    return product.description.isNotEmpty
        ? Padding(
            padding: AppConst.defaultPadding,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: L10n.tr().details, style: TStyle.robotBlackMedium()),
                  const TextSpan(text: '\n'),
                  const WidgetSpan(child: VerticalSpacing(24)),
                  TextSpan(text: product.description, style: TStyle.robotBlackRegular14()),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
