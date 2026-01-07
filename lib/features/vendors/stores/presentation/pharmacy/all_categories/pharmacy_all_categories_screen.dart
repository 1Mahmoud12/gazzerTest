import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_category_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/subcategory/pharmacy_subcategory_screen.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/presentation/extensions/context.dart';

part 'pharmacy_all_categories_screen.g.dart';

/// All categories screen for pharmacy
@TypedGoRoute<PharmacyAllCategoriesRoute>(path: PharmacyAllCategoriesRoute.route)
class PharmacyAllCategoriesRoute extends GoRouteData {
  const PharmacyAllCategoriesRoute();

  static const route = '/pharmacy-all-categories';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PharmacyAllCategoriesScreen();
  }
}

class PharmacyAllCategoriesScreen extends StatelessWidget {
  const PharmacyAllCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = _getAllCategories();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          MenuCategoriesHeaderWidget(title: L10n.tr().categories, colors: [const Color(0xff4A2197), const Color(0xff4AFF5C).withOpacityNew(.8)]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainSearchWidget(hintText: L10n.tr().searchFor),
          ),
          const VerticalSpacing(12),
          // Main Content
          Padding(
            padding: AppConst.defaultHrPadding,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(categories.length, (index) {
                final category = categories[index];
                final screenWidth = MediaQuery.sizeOf(context).width;
                final padding = AppConst.defaultHrPadding.horizontal;
                final availableWidth = screenWidth - padding;
                final cardWidth = (availableWidth - 24) / 3;
                return SizedBox(
                  width: cardWidth,
                  child: PharmacyCategoryCard(
                    id: -category['id'],
                    name: category['name'],
                    imageUrl: category['image'],
                    rating: category['rating'],
                    reviewCount: category['reviews'],
                    onTap: () {
                      context.navigateToPage(PharmacySubcategoryScreen(categoryId: -category['id'], categoryName: category['name']));
                    },
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Static Data ====================

  List<Map<String, dynamic>> _getAllCategories() {
    return [
      {'id': -1, 'name': 'Medications', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', 'rating': 4.5, 'reviews': 100},
      {'id': -2, 'name': 'Skin Care', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', 'rating': 4.5, 'reviews': 100},
      {'id': -3, 'name': 'Hair Care', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', 'rating': 4.5, 'reviews': 100},
      {
        'id': -4,
        'name': 'Vitamins & Dietary',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviews': 100,
      },
      {'id': -5, 'name': 'Beauty Products', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', 'rating': 4.5, 'reviews': 100},
      {'id': -6, 'name': 'Lose Weight', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', 'rating': 4.5, 'reviews': 100},
      {'id': -7, 'name': 'Personal Care', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg', 'rating': 4.5, 'reviews': 100},
      {
        'id': -8,
        'name': 'Mother And Child',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviews': 100,
      },
      {
        'id': -9,
        'name': 'Medical Supplies',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviews': 100,
      },
    ];
  }
}
