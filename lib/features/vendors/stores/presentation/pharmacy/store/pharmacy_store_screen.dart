import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/widgets/gradient_wave_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/daily_offer_style_one.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/daily_offer_style_two.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_banner_slider.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_reviews_section.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/prescription_upload_button.dart';

/// Pharmacy store screen showing products by category
class PharmacyStoreScreen extends StatefulWidget {
  const PharmacyStoreScreen({
    super.key,
    required this.vendorId,
    required this.name,
    required this.logoUrl,
  });

  final int vendorId;
  final String name;
  final String logoUrl;

  @override
  State<PharmacyStoreScreen> createState() => _PharmacyStoreScreenState();
}

class _PharmacyStoreScreenState extends State<PharmacyStoreScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = _getStoreCategories();

    // Create a mock vendor entity for VendorInfoCard
    final mockVendor = StoreEntity(
      id: widget.vendorId,
      name: widget.name,
      image: widget.logoUrl,
      rate: 4.5,
      rateCount: 120,
      zoneName: 'ZAMALEK',
      deliveryTime: '20-30',
      deliveryFee: 15.0,
      parentId: 1,
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

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView(
        children: [
          GradientWaveContainer(
            height: 350,
            child: Column(
              children: [
                const AppBarRowWidget(),

                // Vendor info card
                VendorInfoCard(
                  mockVendor,
                  categories: categories.map((c) => c['name'] as String),
                  onTimerFinish: (ctx) {
                    // Handle timer finish
                  },
                ),

                const VerticalSpacing(16),

                Padding(
                  padding: AppConst.defaultHrPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Pharmacy Stores',
                          style: TStyle.blackBold(
                            22,
                          ).copyWith(color: Co.purple),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: PrescriptionUploadButton(
                          onTap: () {
                            // TODO: Navigate to prescription upload
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          // Search Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              const HorizontalSpacing(6),
              Expanded(
                child: MainSearchWidget(
                  hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                ),
              ),
              const MainCartWidget(),
              const HorizontalSpacing(6),
            ],
          ),
          const SizedBox(height: 16),
          // Banner Slider with Dots
          const PharmacyBannerSlider(
            height: 180,
          ),
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  3,
                  (index) {
                    final selected = index == 0;
                    final category = categories[index];
                    return Container(
                      margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(90),
                        border: Border.all(
                          color: Co.buttonGradient.withOpacityNew(.3),
                          width: 2,
                        ),
                        color: selected == index ? Co.buttonGradient.withOpacityNew(.1) : Colors.transparent,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleGradientBorderedImage(
                            image: category['image'],
                            showBorder: false,
                          ),
                          Padding(
                            padding: AppConst.defaultHrPadding,
                            child: Text(
                              category['name'],
                              style: selected == index ? TStyle.burbleBold(15) : TStyle.blackSemi(13),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ...List.generate(
                      4,
                      (index) => index % 2 == 0
                          ? DailyOfferStyleTwo(
                              product: const ProductEntity(
                                id: 1,
                                name: 'Medical Product Bundle',
                                description: 'Complete medical product set with nasal spray, dropper, and medication',
                                price: 110.0,
                                image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
                                rate: 4.5,
                                reviewCount: 100,
                                outOfStock: false,
                              ),
                              discountPercentage: 30,
                              onTap: () {
                                // TODO: Navigate to product details
                              },
                            )
                          : DailyOfferStyleOne(
                              product: const ProductEntity(
                                id: 1,
                                name: 'Medical Product Bundle',
                                description: 'Complete medical product set with nasal spray, dropper, and medication',
                                price: 110.0,
                                image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
                                rate: 4.5,
                                reviewCount: 100,
                                outOfStock: false,
                              ),
                              discountPercentage: 30,
                              onTap: () {
                                // TODO: Navigate to product details
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Reviews Section
          const PharmacyReviewsSection(
            onViewAll: null, // TODO: Navigate to all reviews
            onAddReview: null, // TODO: Navigate to add review
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  // ==================== Static Data ====================

  List<Map<String, dynamic>> _getStoreCategories() {
    return [
      {
        'name': 'Daily Offers',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
      {
        'name': 'Medications',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
      {
        'name': 'Skin Care',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
      {
        'name': 'Hair Care',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
    ];
  }

  List<ProductEntity> _getProductsForCategory(int categoryIndex) {
    // Generate static products for each category
    final baseId = categoryIndex * 100;

    return List.generate(6, (index) {
      return ProductEntity(
        id: baseId + index,
        name: 'Product ${index + 1}',
        description: 'High quality product from ${widget.name}',
        price: 50.0 + (index * 10),
        image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        rate: 4.0 + (index % 5) * 0.2,
        reviewCount: 50 + index * 10,
        outOfStock: false,
      );
    });
  }
}
