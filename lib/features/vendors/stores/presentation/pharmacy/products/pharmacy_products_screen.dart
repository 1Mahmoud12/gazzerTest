import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_header.dart';
import 'package:go_router/go_router.dart';

/// Pharmacy products screen showing products by category
class PharmacyProductsScreen extends StatefulWidget {
  const PharmacyProductsScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final int categoryId;
  final String categoryName;

  @override
  State<PharmacyProductsScreen> createState() => _PharmacyProductsScreenState();
}

class _PharmacyProductsScreenState extends State<PharmacyProductsScreen> {
  int _selectedCategoryIndex = 0;
  int _selectedSubCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isAr = L10n.isAr(context);
    final categories = _getCategories();
    final subCategories = _getSubCategories();
    final products = _getProducts();

    return Scaffold(
      body: Column(
        children: [
          // Pharmacy Header with gradient and wave
          PharmacyHeader(
            height: 200,
            onBackTap: () => context.pop(),
            onSearch: () {
              // TODO: Navigate to search
            },
          ),

          const SizedBox(height: 16),

          // Category Title
          Padding(
            padding: AppConst.defaultHrPadding,
            child: Align(
              alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                isAr ? '${widget.categoryName} الفئات' : '${widget.categoryName} Categories',
                style: TStyle.burbleBold(20),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Horizontal Category Tabs
          SizedBox(
            height: 60,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) {
                    final selected = index == _selectedCategoryIndex;
                    final category = categories[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategoryIndex = index;
                        });
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                            color: Co.buttonGradient.withOpacityNew(.3),
                            width: 2,
                          ),
                          color: selected ? Co.buttonGradient.withOpacityNew(.1) : Colors.transparent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleGradientBorderedImage(
                              image: category['image'] ?? '',
                              showBorder: false,
                            ),
                            Padding(
                              padding: AppConst.defaultHrPadding,
                              child: Text(
                                category['name'] ?? '',
                                style: selected ? TStyle.burbleBold(15) : TStyle.blackSemi(13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Products Grid with Side Categories
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Side - Sub Categories
                _SubCategoriesList(
                  subCategories: subCategories,
                  selectedIndex: _selectedSubCategoryIndex,
                  onSelect: (index) {
                    setState(() {
                      _selectedSubCategoryIndex = index;
                    });
                  },
                  isAr: isAr,
                ),

                // Right Side - Products Grid
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8,
                      left: 8,
                      bottom: 16,
                    ),
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return VerticalProductCard(
                          product: product,
                          canAdd: true,
                          ignorePointer: true,
                          onTap: () {
                            Alerts.showToast(L10n.tr().comingSoon);
                            //     PlateDetailsRoute(id: product.id).push(context);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, String>> _getCategories() {
    return [
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

  List<Map<String, String>> _getSubCategories() {
    return [
      {
        'name': 'Body Care',
        'image': 'https://images.unsplash.com/photo-1556228852-80c61c8b0add?w=100&h=100&fit=crop',
      },
      {
        'name': 'Face Care',
        'image': 'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=100&h=100&fit=crop',
      },
      {
        'name': 'Sun Protection',
        'image': 'https://images.unsplash.com/photo-1556228578-8c89e6adf883?w=100&h=100&fit=crop',
      },
    ];
  }

  List<ProductEntity> _getProducts() {
    return List.generate(
      6,
      (index) => ProductEntity(
        id: index,
        name: index == 0
            ? 'Micellar Water Skin Cleanser'
            : index == 1
            ? 'Vichy Gel For Skin'
            : index == 2
            ? 'Garnier Purifying For Skin'
            : index == 3
            ? 'Acne Cream'
            : index == 4
            ? 'La Roche-Posay Exfoliating Skin Care'
            : 'La Roche-Posay Cleansing Gel',
        description: 'High quality skin care product',
        price: 110.0,
        image: 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
        rate: 3.5,
        reviewCount: 100,
        outOfStock: false,
      ),
    );
  }
}

class _SubCategoriesList extends StatelessWidget {
  const _SubCategoriesList({
    required this.subCategories,
    required this.selectedIndex,
    required this.onSelect,
    required this.isAr,
  });

  final List<Map<String, String>> subCategories;
  final int selectedIndex;
  final Function(int) onSelect;
  final bool isAr;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = subCategories[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () => onSelect(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
              child: Column(
                children: [
                  // Image Container
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? Co.buttonGradient : Co.grey.withOpacityNew(0.3),
                        width: isSelected ? 3 : 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        subCategory['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Co.bg.withOpacityNew(0.5),
                            child: Icon(
                              Icons.category,
                              color: Co.buttonGradient,
                              size: 30,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Category Name
                  Text(
                    subCategory['name']!,
                    style: isSelected ? TStyle.burbleBold(11) : TStyle.blackRegular(11),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
