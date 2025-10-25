import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';

/// Pharmacy banner slider with promotional offers
class PharmacyBannerSlider extends StatefulWidget {
  const PharmacyBannerSlider({
    super.key,
    this.height = 180.0,
  });

  final double height;

  @override
  State<PharmacyBannerSlider> createState() => _PharmacyBannerSliderState();
}

class _PharmacyBannerSliderState extends State<PharmacyBannerSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banners = _getBanners();

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return _BannerCard(
                banner: banners[index],
              );
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              banners.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Co.buttonGradient : Co.buttonGradient.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getBanners() {
    return [
      {
        'title': 'Antibiotic\nCleansing Gel',
        'discount': '25%',
        'buttonText': 'Order Now',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
      {
        'title': 'Vitamin\nSupplements',
        'discount': '30%',
        'buttonText': 'Shop Now',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
      {
        'title': 'Skin Care\nProducts',
        'discount': '20%',
        'buttonText': 'Buy Now',
        'image': 'https://m.media-amazon.com/images/I/51+DNJFjyGL._AC_SY879_.jpg',
      },
    ];
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.banner,
  });

  final Map<String, dynamic> banner;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Co.greenish.withOpacity(0.3),
            Co.blueish.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Co.buttonGradient.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Left side - Text content
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Discount badge
                Text(
                  banner['discount'],
                  style: TStyle.burbleBold(48).copyWith(
                    height: 1,
                  ),
                ),
                const SizedBox(height: 8),
                // Product title
                Text(
                  banner['title'],
                  style: TStyle.burbleBold(20).copyWith(
                    height: 1.2,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Right side - Product image
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Co.buttonGradient.withOpacity(0.5),
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.network(
                  banner['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Co.buttonGradient.withOpacity(0.1),
                      child: const Icon(
                        Icons.medical_services,
                        size: 60,
                        color: Co.buttonGradient,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
