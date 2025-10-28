import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_cubit.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_card_switcher.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestPopularScreen extends StatelessWidget {
  const BestPopularScreen({super.key});

  static const route = '/best-popular-stores';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showCart: false,
        iconsColor: Co.secondary,
        title: L10n.tr().bestPopularStores,
      ),
      body: BlocProvider(
        create: (context) => di<BestPopularCubit>()..getBestPopularStores(),
        child: BlocBuilder<BestPopularCubit, BestPopularStates>(
          builder: (context, state) {
            if (state is BestPopularLoadingState) {
              return _buildLoadingState();
            }
            if (state is BestPopularErrorState) {
              return FailureComponent(
                message: state.error,
                onRetry: () => context.read<BestPopularCubit>().getBestPopularStores(),
              );
            }
            if (state is BestPopularSuccessState) {
              final stores = state.stores;

              if (stores.isEmpty) {
                return Center(
                  child: Text(
                    L10n.tr().noData,
                    style: TStyle.mainwSemi(14),
                  ),
                );
              }

              return GridView.builder(
                padding: AppConst.defaultPadding,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  final store = stores[index];
                  return GrocCardSwitcher<StoreEntity>(
                    cardStyle: CardStyle.typeOne,
                    width: double.infinity,
                    entity: store,
                    onPressed: () => _navigateToStore(context, store),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return GridView.builder(
      padding: AppConst.defaultPadding,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return const _StoreCardSkeleton();
      },
    );
  }
}

void _navigateToStore(BuildContext context, StoreEntity store) {
  if (store.storeCategoryType == 'Restaurant') {
    context.navigateToPage(
      BlocProvider(
        create: (context) => di<SingleRestaurantCubit>(param1: store.id),
        child: RestaurantDetailsScreen(id: store.id),
      ),
    );
  } else {
    context.navigateToPage(
      BlocProvider(
        create: (context) => di<StoreDetailsCubit>(param1: store.id),
        child: StoreDetailsScreen(storeId: store.id),
      ),
    );
  }
}

class _StoreCardSkeleton extends StatelessWidget {
  const _StoreCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
