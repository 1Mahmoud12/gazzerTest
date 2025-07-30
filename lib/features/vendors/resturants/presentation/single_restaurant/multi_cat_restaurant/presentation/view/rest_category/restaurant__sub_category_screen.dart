import 'package:flutter/material.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/views/widgets/failure_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/common/view/cards/vertical_plate_card.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

part 'restaurant_sub_category_screen.g.dart';

@TypedGoRoute<RestaurantCategoryRoute>(path: RestaurantCategoryScreen.route)
@immutable
class RestaurantCategoryRoute extends GoRouteData with _$RestaurantCategoryRoute {
  const RestaurantCategoryRoute({required this.subCatId, required this.subcatName, required this.$extra});
  final RestaurantEntity $extra;
  final int subCatId;
  final String subcatName;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RestaurantCategoryScreen(
      vendor: $extra,
      subCatId: subCatId,
      subcatName: subcatName,
    );
  }
}

class RestaurantCategoryScreen extends StatelessWidget {
  const RestaurantCategoryScreen({super.key, required this.vendor, required this.subCatId, required this.subcatName});
  final RestaurantEntity vendor;
  final int subCatId;
  final String subcatName;
  static const route = '/restaurant-category';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          MultiCatRestHeader(vendor: vendor),
          Text(subcatName, style: TStyle.primaryBold(16)),
          FutureBuilder(
            future: di<RestaurantsRepo>().getPlatesOfSpecificRestaurantCategory(vendor.id, subCatId),
            builder: (context, snapshot) {
              if (snapshot.hasError || snapshot.data is Err) {
                return FailureWidget(
                  message: L10n.tr().couldnotLoadDataPleaseTryyAgain,
                );
              }
              final isLoading = snapshot.connectionState == ConnectionState.waiting;
              final items = isLoading ? Fakers.plates : (snapshot.data as Ok<List<PlateEntity>>).value;
              return Expanded(
                child: Skeletonizer(
                  enabled: isLoading,
                  child: GridView.builder(
                    padding: AppConst.defaultPadding,

                    itemCount: items.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 235,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      final item = items[index];

                      return VerticalPlateCard(
                        item: item,
                        imgToTextRatio: 0.6,
                        width: double.infinity,
                        corner: Corner.bottomLeft,
                        onTap: (item) {},
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
