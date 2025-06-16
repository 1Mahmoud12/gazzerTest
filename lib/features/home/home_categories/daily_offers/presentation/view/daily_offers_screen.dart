import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/features/home/main_home/presentaion/utils/home_utils.dart';

part 'widgets/daily_offers_header.dart';

class DailyOffersScreen extends StatelessWidget {
  const DailyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false, iconsColor: Co.secondary),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DailyOffersHeader(),
          Padding(
            padding: AppConst.defaultHrPadding,
            child: GradientText(text: "Daily Offers For You", style: TStyle.blackBold(16)),
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
              itemCount: Fakers.fakeProds.length,
              itemBuilder: (context, index) {
                return VerticalProductCard(product: Fakers.fakeProds[index], canAdd: false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
