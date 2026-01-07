import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/products/main_cart_widget.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/app_bar_row_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/utils/header_shape.dart';

/// Reusable pharmacy gradient header with search and action buttons
class PharmacyHeader extends StatelessWidget {
  const PharmacyHeader({
    super.key,
    this.onSearch,
    this.onNotificationTap,
    this.onLanguageTap,
    this.onBackTap,
    this.searchHint = 'search for medication',
    this.height = 220.0,
  });

  final VoidCallback? onSearch;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLanguageTap;
  final VoidCallback? onBackTap;
  final String searchHint;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Background with Custom Shape
        ClipPath(
          clipper: PharmacyHeaderShape(height: height),
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(gradient: Grad().pharmacyLinearGrad),
          ),
        ),

        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top Action Bar
                const AppBarRowWidget(bacButtonColor: Co.mauve, iconsColor: Co.secondary),
                const SizedBox(height: 16),

                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: MainSearchWidget(
                        onChange: (value) {},
                        controller: TextEditingController(),
                        height: 80,
                        hintText: L10n.tr().searchForStoresItemsAndCAtegories,
                        borderRadius: 64,
                        bgColor: Colors.transparent,
                        prefix: const Icon(Icons.search, color: Co.purple, size: 24),
                      ),
                    ),
                    const HorizontalSpacing(10),
                    const MainCartWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
