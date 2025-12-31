import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_cubit.dart';
import 'package:gazzer/features/home/best_popular/presentation/views/best_popular_screen.dart';
import 'package:gazzer/features/home/homeViewAll/best_popular_stores_widget/presentation/cubit/best_popular_stores_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/best_popular_stores_widget/presentation/cubit/best_popular_stores_widget_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_switcher.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';
import 'package:gazzer/main.dart';

class BestPopularStoresWidget extends StatelessWidget {
  const BestPopularStoresWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestPopularStoresWidgetCubit, BestPopularStoresWidgetState>(
      builder: (context, state) {
        if (state is BestPopularStoresWidgetSuccessState) {
          final List<GenericVendorEntity> stores = state.stores;
          if (stores.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return _BestPopularStoresContent(stores: stores, banner: state.banner);
        } else if (state is BestPopularStoresWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (state is BestPopularStoresWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _BestPopularStoresContent extends StatelessWidget {
  const _BestPopularStoresContent({required this.stores, this.banner});

  final List<GenericVendorEntity> stores;
  final BannerEntity? banner;

  @override
  Widget build(BuildContext context) {
    logger.d(stores);
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TitleWithMore(
            title: L10n.tr().bestPopularStores,
            onPressed: () {
              context.navigateToPage(
                BlocProvider(create: (context) => di<BestPopularCubit>()..getBestPopularStores(), child: const BestPopularScreen()),
              );
            },
          ),
          const VerticalSpacing(12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: stores.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final store = stores[index];
                logger.d(store.id);
                return GrocCardSwitcher(
                  cardStyle: CardStyle.typeOne,
                  width: 100,
                  entity: store,
                  onPressed: () {
                    if (store.storeCategoryType == VendorType.restaurant.value) {
                      RestaurantDetailsRoute(id: store.id).push(context);
                    } else if (store.storeCategoryType == VendorType.grocery.value) {
                      StoreDetailsRoute(storeId: store.id).push(context);
                    } else if (store.storeCategoryType == VendorType.pharmacy.value) {
                      PharmacyStoreScreenRoute(id: store.id).push(context);
                    }
                  },
                );
              },
            ),
          ),
          if (banner != null) ...[const VerticalSpacing(24), MainBannerWidget(banner: banner!)],
          const VerticalSpacing(24),
        ]),
      ),
    );
  }
}
