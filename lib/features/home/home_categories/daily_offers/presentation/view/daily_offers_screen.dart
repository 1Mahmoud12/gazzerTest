import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';

class DailyOffersScreen extends StatelessWidget {
  const DailyOffersScreen({super.key, this.items});

  final List<GenericItemEntity?>? items;
  static const route = '/daily-offers';
  @override
  Widget build(BuildContext context) {
    final displayItems = items ?? [];

    return Scaffold(
      appBar: const MainAppBar(showCart: false, iconsColor: Co.secondary),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeCategoriesHeader(),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: GradientText(
              text: L10n.tr().dailyOffersForYou,
              style: TStyle.blackBold(16),
            ),
          ),
          const VerticalSpacing(12),
          Expanded(
            child: displayItems.isEmpty
                ? Center(
                    child: Text(
                      L10n.tr().noData,
                      style: TStyle.mainwSemi(14),
                    ),
                  )
                : GridView.builder(
                    padding: AppConst.defaultPadding,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.84,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: displayItems.length,
                    itemBuilder: (context, index) {
                      if (displayItems[index] == null) {
                        return const SizedBox.shrink();
                      }
                      return VerticalProductCard(
                        product: displayItems[index]!,
                        canAdd: false,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
