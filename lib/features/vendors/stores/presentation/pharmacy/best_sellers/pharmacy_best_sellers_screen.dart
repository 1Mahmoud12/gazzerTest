import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_header.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_product_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_product_card_style2.dart';
import 'package:go_router/go_router.dart';

part 'pharmacy_best_sellers_screen.g.dart';

/// Best sellers screen for pharmacy products
@TypedGoRoute<PharmacyBestSellersRoute>(
  path: PharmacyBestSellersRoute.route,
)
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
      body: Column(
        children: [
          // Pharmacy Header
          PharmacyHeader(
            onBackTap: () => context.pop(),
            onSearch: () {
              // TODO: Navigate to pharmacy search
            },
            onNotificationTap: () {
              // TODO: Navigate to notifications
            },
            onLanguageTap: () {
              // TODO: Toggle language
            },
          ),

          // Main Content
          Expanded(
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              padding: EdgeInsets.zero,
              children: [
                // Title Section
                Padding(
                  padding: AppConst.defaultHrPadding,
                  child: const TitleWithMore(
                    title: 'Best Sellers',
                  ),
                ),
                const VerticalSpacing(16),
                // Products Grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Wrap(
                        runSpacing: 10,
                        spacing: 5,
                        runAlignment: WrapAlignment.spaceAround,
                        alignment: WrapAlignment.spaceEvenly,
                        children: List.generate(bestSellers.length, (index) {
                          final product = bestSellers[index];
                          return index % 2 == 0
                              ? PharmacyProductCardStyle2(
                                  product: product['product'],
                                  vendorName: product['vendorName'],
                                  height: MediaQuery.sizeOf(context).height * .19,
                                  width: MediaQuery.sizeOf(context).width * .46,
                                  onTap: () {
                                    // Handle tap
                                  },
                                )
                              : PharmacyProductCard(
                                  product: product['product'],
                                  vendorName: product['vendorName'],

                                  height: MediaQuery.sizeOf(context).height * .19,
                                  width: MediaQuery.sizeOf(context).width * .46,
                                  onTap: () {
                                    // Handle tap
                                  },
                                );
                        }),
                      ),
                    ),
                  ],
                ),
              ],
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
        'product': const ProductEntity(
          id: 1,
          name: 'Hair Straightening Cream',
          description: 'Professional hair care product',
          price: 110.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 5.0,
          reviewCount: 120,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Al-Azab Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 2,
          name: 'Skin Serum',
          description: 'Anti-aging serum',
          price: 95.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 85,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Health Plus Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 3,
          name: 'Vitamin C Tablets',
          description: 'Immune system support',
          price: 45.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 200,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Care Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 4,
          name: 'Pain Relief Gel',
          description: 'Fast acting pain relief',
          price: 65.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.9,
          reviewCount: 150,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Al-Azab Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 5,
          name: 'Face Moisturizer',
          description: 'Hydrating face cream',
          price: 120.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 95,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Beauty Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 6,
          name: 'Hair Growth Oil',
          description: 'Natural hair growth solution',
          price: 85.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 180,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Natural Care Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 7,
          name: 'Acne Treatment Gel',
          description: 'Clear skin solution',
          price: 75.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.5,
          reviewCount: 160,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Skin Care Plus',
      },
      {
        'product': const ProductEntity(
          id: 8,
          name: 'Multivitamin Complex',
          description: 'Complete daily nutrition',
          price: 55.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 220,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Health First Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 9,
          name: 'Anti-Aging Night Cream',
          description: 'Rejuvenating night treatment',
          price: 140.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.9,
          reviewCount: 110,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Premium Beauty',
      },
      {
        'product': const ProductEntity(
          id: 10,
          name: 'Hair Shampoo & Conditioner',
          description: 'Complete hair care set',
          price: 90.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 175,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Hair Care Specialists',
      },
      {
        'product': const ProductEntity(
          id: 11,
          name: 'Joint Pain Relief Cream',
          description: 'Targeted pain relief',
          price: 70.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 145,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Pain Relief Center',
      },
      {
        'product': const ProductEntity(
          id: 12,
          name: 'Vitamin D3 Supplements',
          description: 'Bone and immune health',
          price: 50.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 195,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Wellness Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 13,
          name: 'Dark Spot Corrector',
          description: 'Even skin tone treatment',
          price: 100.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.5,
          reviewCount: 130,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Skin Solutions',
      },
      {
        'product': const ProductEntity(
          id: 14,
          name: 'Hair Loss Prevention Serum',
          description: 'Strengthen and prevent hair loss',
          price: 125.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 165,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Hair Restoration Clinic',
      },
      {
        'product': const ProductEntity(
          id: 15,
          name: 'Omega-3 Fish Oil',
          description: 'Heart and brain health',
          price: 60.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 210,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Heart Health Pharmacy',
      },
      {
        'product': const ProductEntity(
          id: 16,
          name: 'Sunscreen SPF 50',
          description: 'Broad spectrum protection',
          price: 80.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 185,
          outOfStock: false,
          hasOptions: false,
        ),
        'vendorName': 'Sun Protection Plus',
      },
    ];
  }
}
