import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';

class PopularScreen extends StatelessWidget {
  const PopularScreen({super.key});
  static const route = '/popular-screen';
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
            child: GradientText(text: L10n.tr().suggestedForYou, style: TStyle.blackBold(16)),
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
                final prod = Fakers.plates[index];
                return VerticalRotatedImgCard(
                  prod: prod,
                  onTap: () {
                    PlateDetailsRoute(id: prod.id).push(context);
                  },
                );
              },
            ),
          ),
          const VerticalSpacing(16),
          Expanded(
            child: GridView.builder(
              padding: AppConst.defaultPadding,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: Fakers.plates.length,
              itemBuilder: (context, index) {
                final prod = Fakers.plates[index];
                return VerticalRotatedImgCard(
                  prod: prod,
                  onTap: () {
                    PlateDetailsRoute(id: prod.id).push(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
