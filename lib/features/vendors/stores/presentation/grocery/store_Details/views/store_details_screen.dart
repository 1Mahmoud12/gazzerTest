import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/share/data/share_models.dart';
import 'package:gazzer/features/share/presentation/share_service.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/common/presentation/vendor_info_card.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/unscollable_tabed_list.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_sub_cat_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/groc_header_container.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/store_details_states.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/subcategory/subcategory_items_screen.dart';
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
        onShare: () async {
          animationDialogLoading();
          final result = await ShareService().generateShareLink(
            type: ShareEnumType.store.name,
            shareableType: ShareEnumType.store.name,
            shareableId: storeId.toString(),
          );
          closeDialog();
          switch (result) {
            case Ok<ShareGenerateResponse>(value: final response):
              await Clipboard.setData(ClipboardData(text: response.shareLink));
              if (context.mounted) {
                Alerts.showToast(L10n.tr().link_copied_to_clipboard, error: false);
              }
            case Err<ShareGenerateResponse>(error: final error):
              if (context.mounted) {
                Alerts.showToast(error.message);
              }
          }
        },
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
                      tabs: [
                        // Add best selling items as first tab if available
                        if (state.bestSellingItems.isNotEmpty) ('', L10n.tr().bestSellingItems),
                        // Add all category tabs
                        ...catWithSubCatProds.map((e) => (e.$1.image, e.$1.name)),
                      ],
                      maxHeight: constraints.maxHeight,
                      itemCount: catWithSubCatProds.length + (state.bestSellingItems.isNotEmpty ? 1 : 0),
                      listItemBuilder: (context, index) {
                        // Handle best selling items tab
                        if (state.bestSellingItems.isNotEmpty && index == 0) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: _BestSellingItemsWidget(items: state.bestSellingItems),
                          );
                        }

                        // Handle category tabs (adjust index if best selling items tab exists)
                        final categoryIndex = state.bestSellingItems.isNotEmpty ? index - 1 : index;
                        final item = state.catsWthSubatsAndProds[categoryIndex];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: _GridWidget(maincat: item.$1, onSinglceCardPressed: (item) {}, subcats: item.$2, products: item.$3, vendor: store),
                        );
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

class _BestSellingItemsWidget extends StatelessWidget {
  const _BestSellingItemsWidget({required this.items});

  final List<ProductEntity> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(title: L10n.tr().bestSellingItems),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: AppConst.defaultPadding,
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.59,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            return GrocProdCard(product: items[index], shape: CardStyle.typeOne);
          },
        ),
      ],
    );
  }
}

class _GridWidget extends StatelessWidget {
  const _GridWidget({required this.maincat, required this.onSinglceCardPressed, required this.subcats, required this.products, required this.vendor});
  final StoreCategoryEntity maincat;
  final Function(dynamic item) onSinglceCardPressed;
  final List<StoreCategoryEntity> subcats;
  final List<ProductEntity> products;
  final GenericVendorEntity vendor;
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
                onTap: () {
                  // Check if subcategory has items
                  // For now, we'll show the alert as requested
                  if (subcats[index].products?.isEmpty ?? false) {
                    Alerts.showToast(L10n.tr().noItemsAvailableInThisCategory);
                    return;
                  }

                  context.navigateToPage(
                    SubcategoryItemsScreen(
                      items: subcats[index].products ?? [],
                      subcategoryName: subcats[index].name,
                      vendor: vendor,
                      maincat: maincat.style,
                    ),
                  );
                },
              );
            }
            if (index >= subcats.length) {
              return GrocProdCard(product: products[index - subcats.length], shape: maincat.style);
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }
}
