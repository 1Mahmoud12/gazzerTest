import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});

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
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: AppConst.defaultHrPadding,
              itemCount: 5,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final prod = Fakers.fakeProds[index];
                return VerticalRotatedImgCard(prod: prod);
              },
            ),
          ),
          const VerticalSpacing(16),
          Expanded(
            child: GridView.builder(
              padding: AppConst.defaultPadding,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: Fakers.fakeProds.length,
              itemBuilder: (context, index) {
                final prod = Fakers.fakeProds[index];
                return VerticalRotatedImgCard(prod: prod);
              },
            ),
          ),
        ],
      ),
    );
  }
}
