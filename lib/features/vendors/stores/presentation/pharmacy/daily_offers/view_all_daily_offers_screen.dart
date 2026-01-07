import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/daily_offer_style_one.dart';

/// View all daily offers screen
class ViewAllDailyOffersScreen extends StatelessWidget {
  const ViewAllDailyOffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = _getDailyOfferProducts();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pharmacy Header with gradient and wave
            MenuCategoriesHeaderWidget(title: L10n.tr().todayDeals, colors: [const Color(0xff4A2197), const Color(0xff4AFF5C).withOpacityNew(.8)]),

            Wrap(
              runSpacing: 16,

              children: List.generate(products.length, (index) {
                final product = products[index];
                // Alternate between DailyOfferStyleTwo and DailyOfferStyleOne
                return DailyOfferStyleOne(
                  width: double.infinity,
                  product: product['product'] as ProductEntity,
                  discountPercentage: product['discount'] as int,
                  onTap: () {
                    // TODO: Navigate to product details
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getDailyOfferProducts() {
    return [
      {
        'product': const ProductEntity(
          id: -1,
          sold: 0,

          name: 'Medical Product',
          description: 'High quality medical product',
          price: 110.0,
          image:
              'https://cdn.thewirecutter.com/wp-content/media/2024/12/ROUNDUP-KOREAN-SKINCARE-2048px-9736-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
          rate: 4.5,
          reviewCount: 100,
          outOfStock: false,
        ),
        'discount': 30,
      },
      {
        'product': const ProductEntity(
          id: -2,
          name: 'Medical Product',
          description: 'Premium medical product',
          price: 110.0,
          sold: 0,

          image:
              'https://cdn.thewirecutter.com/wp-content/media/2024/12/ROUNDUP-KOREAN-SKINCARE-2048px-9736-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
          rate: 4.5,
          reviewCount: 100,
          outOfStock: false,
        ),
        'discount': 30,
      },
      {
        'product': const ProductEntity(
          id: -3,
          sold: 0,

          name: 'Medical Product',
          description: 'Essential medical product',
          price: 110.0,
          image:
              'https://cdn.thewirecutter.com/wp-content/media/2024/12/ROUNDUP-KOREAN-SKINCARE-2048px-9736-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
          rate: 4.5,
          reviewCount: 100,
          outOfStock: true,
        ),
        'discount': 0,
      },
      {
        'product': const ProductEntity(
          id: -4,
          sold: 0,

          name: 'serum vitamin c',
          description: 'Vitamin C serum for skin care',
          price: 110.0,
          image: 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&h=400&fit=crop',
          rate: 4.5,
          reviewCount: 100,
          outOfStock: false,
        ),
        'discount': 30,
      },
      {
        'product': const ProductEntity(
          id: -5,
          name: 'serum vitamin c',
          description: 'Vitamin C serum for skin care',
          price: 110.0,
          image: 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=400&h=400&fit=crop',
          rate: 4.5,
          sold: 0,

          reviewCount: 100,
          outOfStock: true,
        ),
        'discount': 0,
      },
      {
        'product': const ProductEntity(
          id: -6,
          sold: 0,

          name: 'Medical Product',
          description: 'High quality medical product',
          price: 110.0,
          image:
              'https://cdn.thewirecutter.com/wp-content/media/2024/12/ROUNDUP-KOREAN-SKINCARE-2048px-9736-2x1-1.jpg?width=2048&quality=75&crop=2:1&auto=webp',
          rate: 4.5,
          reviewCount: 100,
          outOfStock: false,
        ),
        'discount': 30,
      },
    ];
  }
}
