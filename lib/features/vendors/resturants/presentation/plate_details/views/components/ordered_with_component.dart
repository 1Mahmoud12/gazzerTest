import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart' show GradientText, HorizontalSpacing;
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/widgets/ordered_with_card.dart';

class OrderedWithComponent extends StatelessWidget {
  const OrderedWithComponent({super.key, required this.products, required this.title, required this.type});
  final List<OrderedWithEntity> products;
  final String title;
  final CartItemType type;
  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        GradientText(text: title, style: TStyle.blackBold(18)),

        SizedBox(
          height: 170,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              return SizedBox(
                width: 150,
                child: OrderedWithCard(
                  product: products[index],
                  type: type,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
