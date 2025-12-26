import 'package:flutter/material.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/all_categories/pharmacy_all_categories_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/best_sellers/pharmacy_best_sellers_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_category_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/prescription_upload_button.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/subcategory/pharmacy_subcategory_screen.dart';
import 'package:go_router/go_router.dart';

part 'pharmacy_menu_screen.g.dart';

/// Main pharmacy menu screen with static data
@TypedGoRoute<PharmacyMenuRoute>(path: PharmacyMenuRoute.route)
class PharmacyMenuRoute extends GoRouteData {
  const PharmacyMenuRoute();

  static const route = '/pharmacy-menu';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const PharmacyMenuScreen();
  }
}

class PharmacyMenuScreen extends StatelessWidget {
  const PharmacyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pharmacy Header
            MenuCategoriesHeaderWidget(
              title: L10n.tr().pharmacyStores,
              colors: [const Color(0xff4A2197), const Color(0xff4AFF5C).withOpacityNew(.8)],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MainSearchWidget(hintText: L10n.tr().searchFor),
            ),
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

            // Main Content
            const SizedBox(height: 8),

            // Pharmacy Title and Upload Button
            //   _buildTitleSection(context),
            //const SizedBox(height: 16),

            // Delivery Banner
            //   DeliveryBanner(message: 'Free delivery on orders over 300 EG', backgroundColor: Co.buttonGradient.withOpacityNew(.1)),
            //const SizedBox(height: 16),

            // Daily Deal Card
            // DailyDealCard(
            //   imageUrl: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            //   discountPercentage: 30,
            //   endTime: DateTime.now().add(const Duration(hours: 14, minutes: 20, seconds: 30)),
            //   onTap: () {
            //     // TODO: Navigate to daily deal details
            //   },
            // ),
            const MainBannerWidget(banner: BannerEntity(id: 1, type: BannerType.countdown)),
            const SizedBox(height: 24),

            // Categories Section
            _buildCategoriesSection(context),

            const SizedBox(height: 24),

            // Best Sellers Section
            _buildBestSellersSection(context),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              L10n.tr().pharmacyStores,
              style: TStyle.blackBold(22).copyWith(color: Co.purple),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PrescriptionUploadButton(
              onTap: () {
                // TODO: Navigate to prescription upload
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final categories = _getStaticCategories();

    return Column(
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(
            title: L10n.tr().categories,
            onPressed: () {
              context.navigateToPage(const PharmacyAllCategoriesScreen());
            },
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 10,
            children: List.generate(categories.length, (index) {
              final category = categories[index];
              return SizedBox(
                height: 170,
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
    );
  }

  Widget _buildBestSellersSection(BuildContext context) {
    final bestSellers = _getStaticBestSellers();

    return Column(
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(
            title: L10n.tr().bestSellers,
            onPressed: () {
              context.navigateToPage(const PharmacyBestSellersScreen());
            },
          ),
        ),
        const SizedBox(height: 16),
        Padding(
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
                  product: product['product'],
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
      ],
    );
  }

  // ==================== Static Data ====================

  List<Map<String, dynamic>> _getStaticCategories() {
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

  List<Map<String, dynamic>> _getStaticBestSellers() {
    return [
      {
        'product': ProductEntity(
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
        'product': ProductEntity(
          id: -2,
          name: 'Skin Serum',
          description: 'Anti-aging serum',
          price: 95.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.8,
          reviewCount: 85,
          outOfStock: false,
          sold: 0,
          store: SimpleStoreEntity(id: 2, name: 'Health Plus Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Health Plus Pharmacy',
      },
      {
        'product': ProductEntity(
          id: -3,
          name: 'Vitamin C Tablets',
          description: 'Immune system support',
          price: 45.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.7,
          reviewCount: 200,
          outOfStock: false,
          sold: 0,
          store: SimpleStoreEntity(id: 3, name: 'Care Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Care Pharmacy',
      },
      {
        'product': ProductEntity(
          id: -4,
          name: 'Pain Relief Gel',
          description: 'Fast acting pain relief',
          price: 65.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.9,
          reviewCount: 150,
          outOfStock: false,
          sold: 0,
          store: SimpleStoreEntity(id: 1, name: 'Al-Azab Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Al-Azab Pharmacy',
      },
      {
        'product': ProductEntity(
          id: -5,
          name: 'Face Moisturizer',
          description: 'Hydrating face cream',
          price: 120.0,
          image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
          rate: 4.6,
          reviewCount: 95,
          sold: 0,
          outOfStock: false,
          store: SimpleStoreEntity(id: 5, name: 'Beauty Pharmacy', type: VendorType.pharmacy.value, image: ''),
        ),
        'vendorName': 'Beauty Pharmacy',
      },
    ];
  }
}
