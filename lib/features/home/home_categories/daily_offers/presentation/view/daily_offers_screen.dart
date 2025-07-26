import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';

class DailyOffersScreen extends StatelessWidget {
  const DailyOffersScreen({super.key});
  static const route = '/daily-offers';
  @override
  Widget build(BuildContext context) {
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
            child: GradientText(text: L10n.tr().dailyOffersForYou, style: TStyle.blackBold(16)),
          ),
          const VerticalSpacing(12),
          Expanded(
            child: GridView.builder(
              padding: AppConst.defaultPadding,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.88,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: Fakers().fakeProds.length,
              itemBuilder: (context, index) {
                return VerticalProductCard(product: Fakers().fakeProds[index], canAdd: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
