import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/switcher/custom_switcher.dart';
import 'package:gazzer/core/presentation/views/widgets/switcher/switcher_item.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/cards/vertical_restaurant_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  static const route = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final controller = TextEditingController();
  late final FavoriteBus bus;
  String selectedId = 'items';
  @override
  void initState() {
    bus = di<FavoriteBus>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Session().client != null) bus.getFavorites();
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int exitApp = 0;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.go(HomeScreen.route);
      },
      child: Scaffold(
        appBar: MainAppBar(
          title: L10n.tr().favorites,
          onBack: () {
            context.go(HomeScreen.route);
          },
        ),
        body: Column(
          children: [
            if (Session().client == null)
              Expanded(child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseFavorites))
            else
              Expanded(
                child: StreamBuilder<FavoriteEvents>(
                  stream: bus.getStream<FavoriteEvents>(),
                  builder: (context, snapshot) {
                    final event = snapshot.data;

                    if (event is GetFavoriteLoading) {
                      return const Center(child: AdaptiveProgressIndicator());
                    }
                    if (event is ClearFavorites) {
                      return UnAuthComponent(msg: L10n.tr().pleaseLoginToUseFavorites);
                    }
                    if (event == null || event.favorites.isEmpty) {
                      return Center(
                        child: Text(L10n.tr().youHaveNoFavoritesYet, style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple)),
                      );
                    }

                    final allFavorites = event.favorites.values.expand((group) => group.values);
                    final itemFavorites = allFavorites
                        .where((fav) => fav.favoriteType == FavoriteType.plate || fav.favoriteType == FavoriteType.product)
                        .toList();
                    final vendorFavorites = allFavorites
                        .where((fav) => fav.favoriteType == FavoriteType.restaurant || fav.favoriteType == FavoriteType.store)
                        .toList();

                    final currentList = selectedId == 'items' ? itemFavorites : vendorFavorites;

                    return RefreshIndicator(
                      onRefresh: () async {
                        bus.getFavorites();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: AppConst.defaultPadding,
                              child: CustomSwitcher(
                                items: [
                                  SwitcherItem(id: 'items', name: L10n.tr().items),
                                  SwitcherItem(id: 'vendors', name: L10n.tr().vendors),
                                ],
                                selectedId: selectedId,
                                onChanged: (id) {
                                  setState(() {
                                    selectedId = id;
                                  });
                                },
                              ),
                            ),
                            const VerticalSpacing(8),
                            if (currentList.isEmpty)
                              Center(
                                child: Text(L10n.tr().noData, style: TStyle.robotBlackMedium().copyWith(color: Co.purple)),
                              )
                            else
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Padding(
                                    padding: AppConst.defaultPadding,
                                    child: Wrap(
                                      runSpacing: 8,
                                      spacing: 8,
                                      alignment: WrapAlignment.spaceBetween,
                                      children: List.generate(currentList.length, (index) {
                                        final fav = currentList[index];

                                        if (selectedId == 'items') {
                                          return SizedBox(
                                            width: (constraints.maxWidth / 2) - 24,
                                            child: VerticalProductCard(
                                              product: fav as GenericItemEntity,
                                              canAdd: false,
                                              onTap: () {
                                                switch (fav.favoriteType) {
                                                  case FavoriteType.plate:
                                                    PlateDetailsRoute(id: fav.id).push(context);
                                                    break;
                                                  case FavoriteType.product:
                                                    ProductDetailsRoute(productId: fav.id).push(context);
                                                    break;
                                                  default:
                                                    break;
                                                }
                                              },
                                            ),
                                          );
                                        } else if (selectedId == 'vendors') {
                                          final vendor = fav as GenericVendorEntity;
                                          return SizedBox(
                                            width: (constraints.maxWidth / 2) - 24,
                                            child: VerticalRestaurantCard(
                                              width: double.infinity,
                                              item: vendor,
                                              // onTap: (vendor) {
                                              //   // Check favoriteType and storeCategoryType to determine navigation
                                              //   if (vendor.favoriteType ==
                                              //       FavoriteType.restaurant) {
                                              //     // If it's a restaurant type, navigate to restaurant details
                                              //     RestaurantDetailsRoute(
                                              //       id: vendor.id,
                                              //     ).push(context);
                                              //   } else if (vendor
                                              //           .favoriteType ==
                                              //       FavoriteType.store) {
                                              //     // If it's a store type, check storeCategoryType
                                              //     if (vendor
                                              //             .storeCategoryType ==
                                              //         VendorType
                                              //             .restaurant
                                              //             .value) {
                                              //       // Store with restaurant category type -> restaurant details
                                              //       RestaurantDetailsRoute(
                                              //         id: vendor.id,
                                              //       ).push(context);
                                              //     } else {
                                              //       // Other store types -> store details
                                              //       StoreDetailsRoute(
                                              //         storeId: vendor.id,
                                              //       ).push(context);
                                              //     }
                                              //   }
                                              // },
                                            ),
                                          );
                                        }

                                        return const SizedBox.shrink();
                                      }),
                                    ),
                                  );
                                },
                              ),
                            const VerticalSpacing(16),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
