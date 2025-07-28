import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/gradient_border/box_borders/gradient_box_border.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/form_related_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/add_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/core/presentation/views/widgets/products/favorite_widget.dart';
import 'package:gazzer/features/product/add_to_cart/add_food/presentation/add_food_to_cart_screen.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';

part 'widgets/food_details_widget.dart';
part 'widgets/food_images_gallery.dart';

class SingleCatRestaurantScreen extends StatelessWidget {
  const SingleCatRestaurantScreen({super.key, required this.restaurant});
  final RestaurantEntity restaurant;
  @override
  Widget build(BuildContext context) {
    final listItems = [VendorInfoCard(restaurant), const _FoodImagesGallery(), _FoodDetailsWidget(product: Fakers.fakeProds.first)];
    return Scaffold(
      appBar: const MainAppBar(),
      body: ListView.separated(
        itemCount: listItems.length,
        padding: EdgeInsets.only(bottom: MediaQuery.viewPaddingOf(context).bottom + 16),
        separatorBuilder: (context, index) => const VerticalSpacing(24),
        itemBuilder: (context, index) {
          return listItems[index];
        },
      ),
    );
  }
}
