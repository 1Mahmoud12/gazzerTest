import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/widgets/spacing.dart';
import 'package:gazzer/features/resturants_category/presentation/view/components/horizontal_vendor_grid_component.dart';
import 'package:gazzer/features/resturants_category/presentation/view/components/horizontal_vendors_list_component.dart';
import 'package:gazzer/features/resturants_category/presentation/view/components/vertical_vendor_grid_component.dart';
import 'package:gazzer/features/resturants_category/presentation/view/components/vertical_vendors_list_component.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/rest_cat_carousal.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/rest_cat_header_widget.dart';
import 'package:gazzer/features/resturants_category/presentation/view/widgets/sub_categories_widget.dart';

class RestaurantsCatScreen extends StatefulWidget {
  const RestaurantsCatScreen({super.key, required this.id});
  final int id;
  @override
  State<RestaurantsCatScreen> createState() => _RestaurantsCatScreenState();
}

class _RestaurantsCatScreenState extends State<RestaurantsCatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const RestCatHeaderWidget(),
          const RestCatCarousal(),
          const VerticalSpacing(24),
          const SubCategoriesWidget(),
          const VerticalSpacing(24),
          const HorizontalVendorsListComponent(),
          const Divider(height: 33, thickness: 1.5, color: Colors.black45, indent: 32, endIndent: 32,),
          const VerticalVendorsListComponent(),
          const Divider(height: 33, thickness: 1.5, color: Colors.black45, indent: 32, endIndent: 32,),
          const HorizontalVendorGridComponent(),
          const Divider(height: 33, thickness: 1.5, color: Colors.black45, indent: 32, endIndent: 32,),
          const VerticalVendorGridComponent(),

          const VerticalSpacing(80),
        ],
      ),
    );
  }
}
