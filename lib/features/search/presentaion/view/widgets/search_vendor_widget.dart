import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
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
        decoration: BoxDecoration(
          color: Co.lightPurple,
          borderRadius: AppConst.defaultInnerBorderRadius,
        ),
        child: Padding(
          padding: const EdgeInsetsGeometry.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 10,
            children: [
              SearchVendorInfoCard(vendor: vendor),
              if (vendor.items.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (final item in vendor.items)
                        SearchProductWidget(product: item),
                    ],
                  ),
                ),
              // ListView.separated(
              //
              //   itemCount: vendor.items.length,
              //   separatorBuilder: (context, index) => const HorizontalSpacing(12),
              //   itemBuilder: (context, index) {
              //     return SearchProductWidget(product: vendor.items[index]);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
