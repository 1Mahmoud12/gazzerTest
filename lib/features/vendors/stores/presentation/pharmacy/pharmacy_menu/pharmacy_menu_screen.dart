import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/store_menu_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/stores_menu_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/all_categories/pharmacy_all_categories_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/best_sellers/pharmacy_best_sellers_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_category_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/subcategory/pharmacy_subcategory_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'pharmacy_menu_screen.g.dart';

/// Main pharmacy menu screen
@TypedGoRoute<PharmacyMenuRoute>(path: PharmacyMenuRoute.route)
@immutable
class PharmacyMenuRoute extends GoRouteData with _$PharmacyMenuRoute {
  const PharmacyMenuRoute({required this.id});

  final int id;

  static const route = '/pharmacy-menu';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<StoresMenuCubit>(param1: id),
      child: const PharmacyMenuScreen(),
    );
  }
}

class PharmacyMenuScreen extends StatelessWidget {
  const PharmacyMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: BlocBuilder<StoresMenuCubit, StoresMenuStates>(
        builder: (context, state) {
          if (state is ScreenDataError) {
            return FailureComponent(
              message: L10n.tr().couldnotLoadDataPleaseTryAgain,
              onRetry: () => context.read<StoresMenuCubit>().loadScreenData(),
            );
          }

          final banners = state.banners;
          final categories = state.categoryWithStores;

          return Skeletonizer(
            enabled: state is ScreenDataLoading || state is StoresMenuInit,
            child: RefreshIndicator(
              onRefresh: () async {
                await context.read<StoresMenuCubit>().loadScreenData();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Pharmacy Header
                    MenuCategoriesHeaderWidget(title: state.mainCategory.name, colors: [const Color(0xff3AD03F).withOpacityNew(.5), Co.white]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: MainSearchWidget(hintText: L10n.tr().searchFor),
                    ),

                    // Main Content
                    const SizedBox(height: 12),

                    // Banner
                    if (banners.isNotEmpty) MainBannerWidget(banner: banners.first),

                    if (categories.isEmpty) ...[
                      const SizedBox(height: 12),

                      // Categories Section
                      _buildCategoriesSection(context, categories),
                    ],

                    const SizedBox(height: 12),

                    // Best Sellers Section
                    // _buildBestSellersSection(context),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesSection(BuildContext context, List<(StoreCategoryEntity, List<StoreEntity>)> categories) {
    if (categories.isEmpty) {
      // Fallback to static data if no categories from API
      return const SizedBox.shrink();
    }

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
              final category = categories[index].$1;
              return SizedBox(
                height: 170,
                child: PharmacyCategoryCard(
                  id: category.id,
                  name: category.name,
                  imageUrl: category.image,
                  rating: 4.5,
                  reviewCount: 100,
                  onTap: () {
                    context.navigateToPage(PharmacySubcategoryScreen(categoryId: category.id, categoryName: category.name));
                  },
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoriesSectionWithStaticData(BuildContext context) {
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
