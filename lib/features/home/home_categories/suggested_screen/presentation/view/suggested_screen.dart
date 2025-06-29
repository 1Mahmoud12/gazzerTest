import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/gradient_text.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';

class SuggestedScreen extends StatelessWidget {
  const SuggestedScreen({super.key});

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
            child: GradientText(text: "Suggested For You", style: TStyle.blackBold(16)),
          ),
          const VerticalSpacing(12),
          Expanded(
            child: ListView.separated(
              padding: AppConst.defaultPadding,
              shrinkWrap: true,
              itemCount: 4,
              separatorBuilder: (context, index) => const VerticalSpacing(12),
              itemBuilder: (context, index) {
                return HorizontalProductCard(product: Fakers.fakeProds[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
