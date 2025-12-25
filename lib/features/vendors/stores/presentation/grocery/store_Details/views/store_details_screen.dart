import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/helpers.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/icons/cart_to_increment_icon.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/favorites/presentation/views/widgets/favorite_widget.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/generic_sub_category_entity.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/common/view/scrollable_tabed_list.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/widgets/header_widget.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_prod_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/common/cards/groc_sub_cat_card.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
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
          return ScrollableTabedList(
            preHerader: Column(
              spacing: 4,
              children: [
                MultiCatRestHeader(restaurant: store, categires: catWithSubCatProds.map((e) => e.$1.name)),
                // Best Selling Items Widget - outside categories
                if (state.bestSellingItems.isNotEmpty) _BestSellingItemsWidget(items: state.bestSellingItems),
              ],
            ),
            itemsCount: catWithSubCatProds.length,
            tabContainerBuilder: (child) => ColoredBox(color: Co.bg, child: child),
            tabBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // CircleGradientBorderedImage(
                  //   image: catWithSubCatProds[index].$1.image,
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Co.lightGrey),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(catWithSubCatProds[index].$1.name, style: TStyle.blackSemi(13)),
                  ),
                ],
              );
            },
            listItemBuilder: (context, index) {
              final item = state.catsWthSubatsAndProds[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _GridWidget(maincat: item.$1, onSinglceCardPressed: (item) {}, subcats: item.$2, products: item.$3, vendor: store),
              );
            },
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(L10n.tr().bestSellingItems, style: TStyle.robotBlackSubTitle().copyWith(color: Co.purple)),
        ),
        const VerticalSpacing(8),
        SingleChildScrollView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          child: Row(children: items.map((e) => _BestSellingItemCard(e)).toList()),
        ),
      ],
    );
  }
}

class _BestSellingItemCard extends StatelessWidget {
  const _BestSellingItemCard(this.product);

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Co.lightGrey),
      ),
      child: InkWell(
        onTap: () {
          ProductDetailsRoute(productId: product.id).push(context);
        },
        child: Row(
          children: [
            // Left side - Image with favorite icon
            Stack(
              children: [
                CustomNetworkImage(product.image, fit: BoxFit.cover, width: 100, height: 100, borderRaduis: 20),
                Positioned(
                  top: 8,
                  left: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: FavoriteWidget(padding: 2, fovorable: product),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            // Right side - Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product name
                            Row(
                              children: [
                                Expanded(
                                  child: Text(product.name, style: TStyle.robotBlackMedium(), maxLines: 1, overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (product.offer != null) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  '${product.offer!.discount}${product.offer!.discountType == DiscountType.percentage ? '%' : ''}',
                                  style: TStyle.robotBlackMedium(),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            // Rating and Review count
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const VectorGraphicsWidget(Assets.starRateIc),
                                const SizedBox(width: 4),
                                Text(product.rate.toStringAsFixed(1), style: TStyle.blackBold(14)),
                                if (product.reviewCount > 0) ...[
                                  const SizedBox(width: 4),
                                  Text('(+${product.reviewCount})', style: TStyle.greyRegular(12)),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            if (product.sold != null && product.sold! > 0)
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const VectorGraphicsWidget(Assets.soldCartIc),
                                  const HorizontalSpacing(2),
                                  Text(L10n.tr().sold, style: TStyle.robotBlackSmall()),
                                  Text(' +${product.sold}', style: TStyle.robotBlackSmall().copyWith(color: Co.darkGrey)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Helpers.getProperPrice(product.price), style: TStyle.primaryBold(16)),
                              if (product.priceBeforeDiscount != null)
                                Text(
                                  Helpers.getProperPrice(product.priceBeforeDiscount!),
                                  style: TStyle.greyRegular(12).copyWith(decoration: TextDecoration.lineThrough),
                                ),
                            ],
                          ),
                        ],
                      ),
                      // Add to cart button
                      CartToIncrementIcon(isHorizonal: true, product: product, iconSize: 25, isDarkContainer: true),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
      spacing: 8,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: TitleWithMore(title: maincat.name),
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: subcats.length + products.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.45,
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
