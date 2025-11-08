import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/main_search_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/cart/presentation/views/component/un_auth_component.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_bus.dart';
import 'package:gazzer/features/favorites/presentation/favorite_bus/favorite_events.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorites_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});
  static const route = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final controller = TextEditingController();
  late final FavoriteBus bus;
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
        exitApp++;
        //Utils.showToast(title: 'swipe twice to exit', state: UtilState.success);
        Alerts.showToast(L10n.tr().swipeTwiceToExit, error: false, isInfo: true, toastGravity: ToastGravity.CENTER);
        Future.delayed(const Duration(seconds: 5), () {
          exitApp = 0;
          setState(() {});
        });
        if (exitApp == 2) {
          exit(0);
        }
      },
      child: Scaffold(
        appBar: const MainAppBar(showCart: false),
        body: Column(
          spacing: 12,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: MainSearchWidget(
                hintText: L10n.tr().searchForStoresItemsAndCAtegories,
              ),
            ),
            if (Session().client == null)
              Expanded(
                child: UnAuthComponent(msg: L10n.tr().pleaseLoginToUseFavorites),
              )
            else
              Expanded(
                child: StreamBuilder(
                  stream: bus.getStream<FavoriteEvents>(),
                  builder: (context, snapshot) {
                    // print("favs of restaurant  ${bus.favorites[FavoriteType.restaurant]}");
                    if (snapshot.data is GetFavoriteLoading) {
                      return const Center(child: AdaptiveProgressIndicator());
                    }
                    if (snapshot.data is ClearFavorites) {
                      return UnAuthComponent(
                        msg: L10n.tr().pleaseLoginToUseFavorites,
                      );
                    }
                    if (snapshot.data?.favorites == null || snapshot.data!.favorites.isEmpty) {
                      return Center(
                        child: Text(
                          L10n.tr().youHaveNoFavoritesYet,
                          style: TStyle.primaryBold(20),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        bus.getFavorites();
                      },
                      child: ListView.separated(
                        itemCount: snapshot.data!.favorites.length,
                        padding: AppConst.defaultPadding,
                        separatorBuilder: (context, index) => const VerticalSpacing(24),
                        itemBuilder: (context, index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Text(
                                snapshot.data!.favorites.keys.elementAt(index).trName,
                                style: TStyle.primaryBold(20),
                              ),
                              SizedBox(
                                height: 200,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.favorites.values.elementAt(index).length,
                                  separatorBuilder: (context, index) => const HorizontalSpacing(16),
                                  itemBuilder: (context, i) {
                                    final fav = snapshot.data!.favorites.values.elementAt(index).values.elementAt(i);
                                    return FavoriteCard(
                                      favorite: fav,
                                      onTap: () {
                                        switch (fav.favoriteType) {
                                          case FavoriteType.restaurant:
                                            RestaurantDetailsRoute(
                                              id: fav.id,
                                            ).push(context);
                                            break;
                                          case FavoriteType.store:
                                            StoreDetailsRoute(
                                              storeId: fav.id,
                                            ).push(context);
                                            break;
                                          case FavoriteType.plate:
                                            PlateDetailsRoute(
                                              id: fav.id,
                                            ).push(context);
                                          case FavoriteType.product:
                                            ProductDetailsRoute(
                                              productId: fav.id,
                                            ).push(context);
                                            break;
                                          default:
                                            break;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
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
