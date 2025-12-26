import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:go_router/go_router.dart';

part 'pharmacy_best_sellers_screen.g.dart';

/// Best sellers screen for pharmacy products
@TypedGoRoute<PharmacyBestSellersRoute>(path: PharmacyBestSellersRoute.route)
class PharmacyBestSellersRoute extends GoRouteData {
  const PharmacyBestSellersRoute();

  static const route = '/pharmacy-best-sellers';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PharmacyBestSellersScreen();
  }
}

class PharmacyBestSellersScreen extends StatelessWidget {
  const PharmacyBestSellersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bestSellers = _getAllBestSellers();

    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          MenuCategoriesHeaderWidget(title: L10n.tr().bestSellers, colors: [const Color(0xff4A2197), const Color(0xff4AFF5C).withOpacityNew(.8)]),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: MainSearchWidget(hintText: L10n.tr().searchFor),
          ),
          // Pharmacy Header
          // PharmacyHeader(
          //   onBackTap: () => context.pop(),
          //   onSearch: () {
          //     // TODO: Navigate to pharmacy search
          //   },
          //   onNotificationTap: () {
          //     // TODO: Navigate to notifications
          //   },
          //   onLanguageTap: () {
          //     // TODO: Toggle language
          //   },
          // ),
          const VerticalSpacing(12),
          // Main Content
          Expanded(
            child: Padding(
              padding: AppConst.defaultHrPadding,
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(bestSellers.length, (index) {
                  final product = bestSellers[index];
                  final screenWidth = MediaQuery.sizeOf(context).width;
                  final padding = AppConst.defaultHrPadding.horizontal;
                  final availableWidth = screenWidth - padding;
                  final cardWidth = (availableWidth - 12) / 2;
                  return SizedBox(
                    width: cardWidth,
                    child: VerticalProductCard(
                      product: product['pharmacies'],
                      pharmacy: true,
                      canAdd: true,
                      onTap: () {
                        // TODO: Navigate to product details
                      },
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== Static Data ====================

  List<Map<String, dynamic>> _getAllBestSellers() {
    return [
      {
        'pharmacies': ProductEntity(
          id: -1,
          name: 'Hair Straightening Cream',
          description: 'Professional hair care product',
          price: 110.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 5.0,
          reviewCount: 120,
          outOfStock: false,
          sold: 0,
          store: SimpleStoreEntity(id: 1, name: 'Al-Azab Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Al-Azab Pharmacy',
      },
      {
        'pharmacies': ProductEntity(
          id: -1,
          name: 'Hair Straightening Cream',
          description: 'Professional hair care product',
          price: 110.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 5.0,
          reviewCount: 120,
          outOfStock: false,
          sold: 0,
          store: SimpleStoreEntity(id: 1, name: 'Al-Azab Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Health Plus Pharmacy',
      },
      {
        'pharmacies': ProductEntity(
          id: -1,
          name: 'Hair Straightening Cream',
          description: 'Professional hair care product',
          price: 110.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 5.0,
          reviewCount: 120,
          outOfStock: false,
          sold: 0,
          store: SimpleStoreEntity(id: 1, name: 'Al-Azab Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Care Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -4,
          sold: 0,

          name: 'Pain Relief Gel',
          description: 'Fast acting pain relief',
          price: 65.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.9,
          reviewCount: 150,
          outOfStock: false,
        ),
        'vendorName': 'Al-Azab Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -5,
          name: 'Face Moisturizer',
          description: 'Hydrating face cream',
          price: 120.0,
          sold: 0,

          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 95,
          outOfStock: false,
        ),
        'vendorName': 'Beauty Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -6,
          name: 'Hair Growth Oil',
          description: 'Natural hair growth solution',
          price: 85.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 180,
          sold: 0,

          outOfStock: false,
        ),
        'vendorName': 'Natural Care Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -7,
          sold: 0,

          name: 'Acne Treatment Gel',
          description: 'Clear skin solution',
          price: 75.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.5,
          reviewCount: 160,
          outOfStock: false,
        ),
        'vendorName': 'Skin Care Plus',
      },
      {
        'pharmacies': const ProductEntity(
          id: -8,
          sold: 0,

          name: 'Multivitamin Complex',
          description: 'Complete daily nutrition',
          price: 55.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 220,
          outOfStock: false,
        ),
        'vendorName': 'Health First Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -9,
          sold: 0,

          name: 'Anti-Aging Night Cream',
          description: 'Rejuvenating night treatment',
          price: 140.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.9,
          reviewCount: 110,
          outOfStock: false,
        ),
        'vendorName': 'Premium Beauty',
      },
      {
        'pharmacies': const ProductEntity(
          id: -10,
          sold: 0,

          name: 'Hair Shampoo & Conditioner',
          description: 'Complete hair care set',
          price: 90.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 175,
          outOfStock: false,
        ),
        'vendorName': 'Hair Care Specialists',
      },
      {
        'pharmacies': const ProductEntity(
          id: -11,
          sold: 0,

          name: 'Joint Pain Relief Cream',
          description: 'Targeted pain relief',
          price: 70.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 145,
          outOfStock: false,
        ),
        'vendorName': 'Pain Relief Center',
      },
      {
        'pharmacies': const ProductEntity(
          id: -12,
          sold: 0,

          name: 'Vitamin D3 Supplements',
          description: 'Bone and immune health',
          price: 50.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 195,
          outOfStock: false,
        ),
        'vendorName': 'Wellness Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -13,
          sold: 0,

          name: 'Dark Spot Corrector',
          description: 'Even skin tone treatment',
          price: 100.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.5,
          reviewCount: 130,
          outOfStock: false,
        ),
        'vendorName': 'Skin Solutions',
      },
      {
        'pharmacies': const ProductEntity(
          id: -14,
          sold: 0,

          name: 'Hair Loss Prevention Serum',
          description: 'Strengthen and prevent hair loss',
          price: 125.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 165,
          outOfStock: false,
        ),
        'vendorName': 'Hair Restoration Clinic',
      },
      {
        'pharmacies': const ProductEntity(
          id: -15,
          sold: 0,

          name: 'Omega-3 Fish Oil',
          description: 'Heart and brain health',
          price: 60.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 210,
          outOfStock: false,
        ),
        'vendorName': 'Heart Health Pharmacy',
      },
      {
        'pharmacies': const ProductEntity(
          id: -16,
          sold: 0,

          name: 'Sunscreen SPF 50',
          description: 'Broad spectrum protection',
          price: 80.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 185,
          outOfStock: false,
        ),
        'vendorName': 'Sun Protection Plus',
      },
    ];
  }
}
