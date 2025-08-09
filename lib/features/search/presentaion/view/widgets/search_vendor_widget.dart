import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/search_product_widget.dart';
import 'package:gazzer/features/search/presentaion/view/widgets/search_vendor_info_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchVendorWidget extends StatelessWidget {
  const SearchVendorWidget({super.key, required this.vendor});
  final SearchVendorEntity vendor;
  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: Grad().bglightLinear, borderRadius: AppConst.defaultInnerBorderRadius),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(12),
          child: Column(
            spacing: 10,
            children: [
              SearchVendorInfoCard(vendor: vendor),
              SizedBox(
                height: 125,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: vendor.items.length,
                  separatorBuilder: (context, index) => const HorizontalSpacing(12),
                  itemBuilder: (context, index) {
                    return SearchProductWidget(product: vendor.items[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
