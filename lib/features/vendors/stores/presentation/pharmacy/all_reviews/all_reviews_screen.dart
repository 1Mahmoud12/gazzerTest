import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/extensions/color.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_header.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/common/widgets/pharmacy_reviews_section.dart';
import 'package:go_router/go_router.dart';

/// View all daily offers screen
class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAr = L10n.isAr(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pharmacy Header with gradient and wave
            PharmacyHeader(
              onBackTap: () => context.pop(),
              onSearch: () {
                // TODO: Navigate to search
              },
            ),

            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: HeaderSection(
                isAr: isAr,
              ),
            ),

            const VerticalSpacing(16),

            // Divider
            Container(
              height: 1,
              color: Co.grey.withOpacityNew(0.3),
            ),

            const VerticalSpacing(20),

            // Reviews List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ReviewsList(
                isAr: isAr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
