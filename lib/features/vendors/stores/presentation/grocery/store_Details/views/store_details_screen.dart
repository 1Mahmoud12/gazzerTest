import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/unscollable_tabed_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_sub_cat_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/groc_header_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/store_details_states.dart';
import 'package:go_router/go_router.dart';

part 'store_details_screen.g.dart';

@TypedGoRoute<StoreDetailsRoute>(path: StoreDetailsScreen.route)
@immutable
class StoreDetailsRoute extends GoRouteData with _$StoreDetailsRoute {
  const StoreDetailsRoute({required this.storeId});
  final int storeId;
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => di<StoreDetailsCubit>(param1: storeId),
      child: StoreDetailsScreen(storeId: storeId),
    );
  }
}

class StoreDetailsScreen extends StatelessWidget {
  static const route = '/store-details';
  const StoreDetailsScreen({super.key, required this.storeId});
  final int storeId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        onShare: () {},
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: BlocBuilder<StoreDetailsCubit, StoreDetailsStates>(
        builder: (context, state) {
          if (state is StoreDetailsError) {
            return FailureComponent(
              message: L10n.tr().couldnotLoadDataPleaseTryAgain,
              onRetry: () => context.read<StoreDetailsCubit>().loadScreenData(),
            );
          } else if (state is StoreDetailsLoading) {
            return const Center(child: AdaptiveProgressIndicator());
          }
          final store = state.store;
          final catWithSubCatProds = state.catsWthSubatsAndProds;
          return Column(
            spacing: 12,
            children: [
              GrocHeaderContainer(
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
                  child: VendorInfoCard(
                    store,
                    categories: catWithSubCatProds.map((e) => e.$1.name),
                    onTimerFinish: (ctx) {
                      StoreDetailsRoute(storeId: storeId).pushReplacement(ctx);
                    },
                  ),
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) => RefreshIndicator(
                    onRefresh: () async {
                      return context.read<StoreDetailsCubit>().loadScreenData();
                    },
                    child: UnScollableLTabedList(
                      tabs: catWithSubCatProds.map((e) => (e.$1.image, e.$1.name)).toList(),
                      maxHeight: constraints.maxHeight,
                      itemCount: catWithSubCatProds.length,
                      listItemBuilder: (context, index) {
                        final item = state.catsWthSubatsAndProds[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: _gridWidget(
                            maincat: item.$1,
                            onSinglceCardPressed: (item) {},
                            subcats: item.$2,
                            products: item.$3,
                          ),
                        );
                        // GrocVertScrollGrid(
                        //   title: catWithSubCatProds[index].$1.name,
                        //   onViewAllPressed: () {},
                        //   items: [...catWithSubCatProds[index].$2, ...catWithSubCatProds[index].$3],
                        //   onSinglceCardPressed: (item) {},
                        //   shrinkWrap: true,
                        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 3,
                        //     childAspectRatio: 0.56,
                        //     crossAxisSpacing: 8,
                        //     mainAxisSpacing: 8,
                        //   ),
                        // ),
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _gridWidget extends StatelessWidget {
  const _gridWidget({
    required this.maincat,
    required this.onSinglceCardPressed,
    required this.subcats,
    required this.products,
  });
  final StoreCategoryEntity maincat;
  final Function(dynamic item) onSinglceCardPressed;
  final List<StoreCategoryEntity> subcats;
  final List<ProductEntity> products;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(title: maincat.name),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),

          shrinkWrap: true,
          padding: AppConst.defaultPadding,
          itemCount: subcats.length + products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.59,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            if (index < subcats.length) {
              return GrocSubCatCard(
                subCat: subcats[index],
                shape: maincat.style,
              );
            }
            if (index >= subcats.length) {
              return GrocProdCard(
                product: products[index - subcats.length],
                shape: maincat.style,
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
