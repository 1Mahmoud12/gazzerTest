import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/grid_categories_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/daily_offer_style_one.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/daily_offers/view_all_daily_offers_screen.dart';
import 'package:go_router/go_router.dart';

part 'pharmacy_store_screen.g.dart';

@TypedGoRoute<PharmacyStoreScreenRoute>(path: PharmacyStoreScreen.route)
@immutable
class PharmacyStoreScreenRoute extends GoRouteData with _$PharmacyStoreScreenRoute {
  const PharmacyStoreScreenRoute({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PharmacyStoreScreen(vendorId: id);
  }
}

/// Pharmacy store screen showing products by category
class PharmacyStoreScreen extends StatelessWidget {
  const PharmacyStoreScreen({super.key, required this.vendorId});

  static const route = '/pharmacy-store';

  final int vendorId;

  final String name = 'Pharmacy';

  final String logoUrl = '';

  @override
  Widget build(BuildContext context) {
    // Create a mock vendor entity for VendorInfoCard
    final mockVendor = StoreEntity(
      id: -vendorId,
      name: name,
      description:
          'Description: A juicy, flame-grilled beef patty served with fresh toppings and a toasted bun.Ingredients: 100% Angus beef patty, lettuce, tomato, pickles, onions, house sauce, sesame bun.',
      totalOrders: 120,
      image: logoUrl,
      estimatedDeliveryTime: 20,
      storeCategoryType: VendorType.pharmacy.value,
      rate: 4.5,
      rateCount: 120,
      hasOptions: false,
      zoneName: 'ZAMALEK',
      deliveryTime: '20-30',
      deliveryFee: 15.0,
      parentId: -1,
      isFavorite: false,
      isOpen: true,
      outOfStock: false,
      reviewCount: 120,
      alwaysOpen: false,
      alwaysClosed: false,
      startTime: DateTime.now().subtract(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 10)),
      mintsBeforClosingAlert: 30,
    );

    final catWithSubCatProds = _getCategoriesWithSubcatsAndProducts();

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ScrollableTabedList(
        preHerader: Column(
          spacing: 4,
          children: [
            MultiCatRestHeader(restaurant: mockVendor, categires: catWithSubCatProds.map((e) => e.$1.name)),
            // Today's Deals Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TitleWithMore(
                title: L10n.tr().todayDeals,
                titleStyle: TStyle.blackBold(20),
                onPressed: () {
                  context.navigateToPage(const ViewAllDailyOffersScreen());
                },
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  ...List.generate(4, (index) {
                    return DailyOfferStyleOne(
                      product: ProductEntity(
                        id: -1,
                        sold: 0,
                        name: 'Medical Product Bundle',
                        description: 'Complete medical product set with nasal spray, dropper, and medication',
                        price: 110.0,
                        image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
                        rate: 4.5,
                        reviewCount: 100,
                        outOfStock: false,
                        offer: OfferEntity(
                          id: -1,
                          maxDiscount: 900,
                          expiredAt: DateTime.now().add(const Duration(days: 30)).timeZoneName,
                          discount: 30,
                          discountType: DiscountType.percentage,
                        ),
                      ),
                      onTap: () {
                        // TODO: Navigate to product details
                      },
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
        itemsCount: catWithSubCatProds.length,
        tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
        tabBuilder: (context, index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Co.lightGrey),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(catWithSubCatProds[index].$1.name, style: TStyle.blackSemi(13)),
              ),
            ],
          );
        },
        listItemBuilder: (context, index) {
          final item = catWithSubCatProds[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: GridWidget(maincat: item.$1, onSinglceCardPressed: (item) {}, subcats: const [], products: item.$3, vendor: mockVendor),
          );
        },
      ),
    );
  }

  // ==================== Static Data ====================
  List<(StoreCategoryEntity, List<StoreCategoryEntity>, List<ProductEntity>)> _getCategoriesWithSubcatsAndProducts() {
    return [
      (
        // Main category: Medications
        const StoreCategoryEntity(id: -1, name: 'Medications', image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg'),
        // Subcategories
        [
          const StoreCategoryEntity(
            id: -11,
            name: 'Pain Relief',
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            parentId: -1,
            products: [],
          ),
          const StoreCategoryEntity(
            id: -11,
            name: 'Pain Relief',
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            parentId: -1,
            products: [],
          ),
          const StoreCategoryEntity(
            id: -11,
            name: 'Pain Relief',
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            parentId: -1,
            products: [],
          ),
          const StoreCategoryEntity(
            id: -12,
            name: 'Antibiotics',
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            parentId: -1,
            products: [],
          ),
        ],
        // Products
        [
          const ProductEntity(
            id: -101,
            name: 'Pain Relief Gel',
            description: 'Fast acting pain relief',
            price: 65.0,
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            rate: 4.9,
            reviewCount: 150,
            outOfStock: false,
            sold: 0,
          ),
          const ProductEntity(
            id: -101,
            name: 'Pain Relief Gel',
            description: 'Fast acting pain relief',
            price: 65.0,
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            rate: 4.9,
            reviewCount: 150,
            outOfStock: false,
            sold: 0,
          ),
          const ProductEntity(
            id: -101,
            name: 'Pain Relief Gel',
            description: 'Fast acting pain relief',
            price: 65.0,
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            rate: 4.9,
            reviewCount: 150,
            outOfStock: false,
            sold: 0,
          ),
          const ProductEntity(
            id: -102,
            name: 'Antibiotic Cream',
            description: 'Topical antibiotic treatment',
            price: 45.0,
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            rate: 4.7,
            reviewCount: 200,
            outOfStock: false,
            sold: 0,
          ),
        ],
      ),
      (
        // Main category: Skin Care
        const StoreCategoryEntity(id: -2, name: 'Skin Care', image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg'),
        // Subcategories
        [
          const StoreCategoryEntity(
            id: -21,
            name: 'Face Care',
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            parentId: -2,
            products: [],
          ),
          const StoreCategoryEntity(
            id: -22,
            name: 'Body Care',
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            parentId: -2,
            products: [],
          ),
        ],
        // Products
        [
          const ProductEntity(
            id: -201,
            name: 'Face Moisturizer',
            description: 'Hydrating face cream',
            price: 120.0,
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            rate: 4.6,
            reviewCount: 95,
            outOfStock: false,
            sold: 0,
          ),
          const ProductEntity(
            id: -202,
            name: 'Skin Serum',
            description: 'Anti-aging serum',
            price: 95.0,
            image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
            rate: 4.8,
            reviewCount: 85,
            outOfStock: false,
            sold: 0,
          ),
        ],
      ),
    ];
  }
}
