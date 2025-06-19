import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/infinite_scrolling.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/add_shape_clipper.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/image_in_nested_circles.dart';
import 'package:gazzer/core/presentation/views/widgets/products/rating_widget.dart';
import 'package:gazzer/features/resturants/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/resturants/single_restaurant/single_cat_restaurant/view/single_restaurant_details.dart';

// components
part 'components/explore_best.dart';
part 'components/pick_to_you.dart';
part 'components/today_picks_widget.dart';
/// screen widgets
part 'widgets/add_widget.dart';
part 'widgets/infinet_carousal.dart';
part 'widgets/type_related_restaurants_header.dart';

class CatRelatedRestaurantsScreen extends StatelessWidget {
  const CatRelatedRestaurantsScreen({super.key, required this.id});
  final int id;
  @override
  Widget build(BuildContext context) {
    final items = [
      const _TypeRelatedRestaurantsHeader(),
      const _InfinetAnimatingCarousal(),
      const _TodayPicksWidget(),
      const _ExploreBest(),
      const _AddWidget(),
      const _PickToYou(),
    ];
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (context, index) => index < 1 ? const SizedBox.shrink() : const VerticalSpacing(24),
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
        itemBuilder: (context, index) {
          return items[index];
        },
      ),
    );
  }
}
