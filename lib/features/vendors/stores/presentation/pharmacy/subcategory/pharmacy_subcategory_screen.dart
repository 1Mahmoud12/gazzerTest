import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/subcategory/widgets/pharmacy_scrollable_tab_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/subcategory/widgets/pharmacy_vendor_card.dart';
import 'package:go_router/go_router.dart';

part 'pharmacy_subcategory_screen.g.dart';

/// Pharmacy subcategory screen showing vendors for a specific category
@TypedGoRoute<PharmacySubcategoryRoute>(path: PharmacySubcategoryRoute.route)
class PharmacySubcategoryRoute extends GoRouteData {
  const PharmacySubcategoryRoute({required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;

  static const route = '/pharmacy-subcategory/:categoryId/:categoryName';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PharmacySubcategoryScreen(categoryId: categoryId, categoryName: categoryName);
  }
}

class PharmacySubcategoryScreen extends StatefulWidget {
  const PharmacySubcategoryScreen({super.key, required this.categoryId, required this.categoryName});

  final int categoryId;
  final String categoryName;

  @override
  State<PharmacySubcategoryScreen> createState() => _PharmacySubcategoryScreenState();
}

class _PharmacySubcategoryScreenState extends State<PharmacySubcategoryScreen> {
  final Set<int> _favoriteVendorIds = {};

  @override
  Widget build(BuildContext context) {
    final subcategories = _getSubcategories();

    return Scaffold(
      backgroundColor: Co.white,
      body: PharmacyScrollableTabedList(
        itemsCount: subcategories.length,

        preHerader: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Pharmacy Header
            MenuCategoriesHeaderWidget(
              title: L10n.tr().pharmacyStores,
              colors: [const Color(0xff4A2197), const Color(0xff4AFF5C).withOpacityNew(.8)],
            ),

            const SizedBox(height: 16),

            // Category Title
            Padding(
              padding: AppConst.defaultHrPadding,
              child: Text('${widget.categoryName} Pharmacies', style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple)),
            ),

            const SizedBox(height: 16),
          ],
        ),
        tabContainerBuilder: (child) {
          return Container(color: Co.white, child: child);
        },
        tabBuilder: (context, index, selected) {
          final subcategory = subcategories[index];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(90),
              border: Border.all(color: Co.lightPurple, width: 2),
              color: selected == index ? Co.purple : Co.white,
            ),
            padding: const EdgeInsets.all(8),

            child: Text(subcategory['name'], style: TStyle.robotBlackMedium().copyWith(color: selected == index ? Co.white : Co.black)),
          );
        },
        listItemBuilder: (context, index) {
          final vendors = _getVendorsForSubcategory(index);

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pharmacies Title
                Padding(
                  padding: AppConst.defaultHrPadding,
                  child: Text(subcategories[index]['name'], style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
                ),

                const SizedBox(height: 12),

                // Vendors List
                ...vendors.map((vendor) {
                  final isFavorite = _favoriteVendorIds.contains(-vendor['id']);

                  return Padding(
                    padding: AppConst.defaultHrPadding,
                    child: PharmacyVendorCard(
                      id: -vendor['id'],
                      name: vendor['name'],
                      logoUrl: vendor['logo'],
                      rating: vendor['rating'],
                      reviewCount: vendor['reviewCount'],
                      location: vendor['location'],
                      deliveryTime: vendor['deliveryTime'],
                      discountPercentage: vendor['discountPercentage'],
                      isClosed: vendor['isClosed'],
                      isFavorite: isFavorite,
                      onTap: () {
                        context.navigateToPage(PharmacyStoreScreen(vendorId: -vendor['id']));
                      },
                      onFavoriteTap: () {
                        setState(() {
                          if (isFavorite) {
                            _favoriteVendorIds.remove(-vendor['id']);
                          } else {
                            _favoriteVendorIds.add(-vendor['id']);
                          }
                        });
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        },
      ),
    );
  }

  // ==================== Static Data ====================

  List<Map<String, dynamic>> _getSubcategories() {
    // Different subcategories based on main category
    if (widget.categoryId == 1) {
      // Medications subcategories
      return [
        {'name': 'Medications', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg'},
        {'name': 'Skin Care', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg'},
        {'name': 'Hair Care', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg'},
      ];
    }

    // Default subcategories
    return [
      {'name': 'All', 'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg'},
    ];
  }

  List<Map<String, dynamic>> _getVendorsForSubcategory(int subcategoryIndex) {
    // Static vendor data for demonstration
    // In production, this would filter vendors based on subcategory
    return [
      {
        'id': -subcategoryIndex * 10 + 1,
        'name': 'Green Leaf Pharmacy',
        'logo': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviewCount': 100,
        'location': 'ZAMALEK',
        'deliveryTime': '20-30 MIN',
        'discountPercentage': 30,
        'isClosed': false,
      },
      {
        'id': -subcategoryIndex * 10 + 2,
        'name': 'Green Leaf Pharmacy',
        'logo': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviewCount': 100,
        'location': 'ZAMALEK',
        'deliveryTime': '20-30 MIN',
        'discountPercentage': 30,
        'isClosed': false,
      },
      {
        'id': -subcategoryIndex * 10 + 3,
        'name': 'Green Leaf Pharmacy',
        'logo': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviewCount': 100,
        'location': 'ZAMALEK',
        'deliveryTime': '20-30 MIN',
        'discountPercentage': null,
        'isClosed': true,
      },
      {
        'id': -subcategoryIndex * 10 + 4,
        'name': 'Green Leaf Pharmacy',
        'logo': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviewCount': 100,
        'location': 'ZAMALEK',
        'deliveryTime': '20-30 MIN',
        'discountPercentage': 30,
        'isClosed': false,
      },
      {
        'id': -subcategoryIndex * 10 + 5,
        'name': 'Green Leaf Pharmacy',
        'logo': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        'rating': 4.5,
        'reviewCount': 100,
        'location': 'ZAMALEK',
        'deliveryTime': '20-30 MIN',
        'discountPercentage': null,
        'isClosed': true,
      },
    ];
  }
}
