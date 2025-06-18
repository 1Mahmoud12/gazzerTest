import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gazzer/core/data/fakers.dart';
import 'package:gazzer/core/domain/product/product_model.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/vendor_model.dart';

part 'widgets/food_details_widget.dart';
part 'widgets/food_images_gallery.dart';
part 'widgets/vendor_card.dart';

class SingleRestaurantDetailsScreen extends StatelessWidget {
  const SingleRestaurantDetailsScreen({super.key, required this.product});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    final listItems = [
      _VendorCard(Fakers.vendors.first),
      const _FoodImagesGallery(),
      _FoodDetailsWidget(product: product),
    ];
    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView.builder(
        itemCount: listItems.length,
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
        itemBuilder: (context, index) {
          return listItems[index];
        },
      ),
    );
  }
}
