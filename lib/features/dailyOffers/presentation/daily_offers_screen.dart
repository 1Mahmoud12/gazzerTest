import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/switcher/custom_switcher.dart';
import 'package:gazzer/core/presentation/views/widgets/switcher/switcher_item.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_cubit.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';

class DailyOffersScreen extends StatefulWidget {
  const DailyOffersScreen({super.key});
  static const route = '/daily-offers';

  @override
  State<DailyOffersScreen> createState() => _DailyOffersScreenState();
}

class _DailyOffersScreenState extends State<DailyOffersScreen> {
  Timer? _debounceTimer;
  String _currentSearch = '';
  DailyOfferCubit? _cubit;
  final ScrollController _scrollController = ScrollController();
  String selectedId = 'items';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = _cubit;
      if (cubit != null) {
        final currentState = cubit.state;
        if (cubit.hasMore && currentState is! DailyOfferLoadingMoreState) {
          final type = selectedId == 'items' ? 'items' : 'stores';
          cubit.getAllOffers(search: _currentSearch.isEmpty ? null : _currentSearch, type: type, loadMore: true);
        }
      }
    }
  }

  void onChanged(String id) {
    setState(() {
      selectedId = id;
    });
    // Fetch data with the new type
    final type = id == 'items' ? 'items' : 'stores';
    _cubit?.getAllOffers(search: _currentSearch.isEmpty ? null : _currentSearch, type: type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: L10n.tr().dailyOffersForYou,
        titleStyle: TStyle.robotBlackTitle().copyWith(color: Co.purple),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //          HomeCategoriesHeader(onChange: _onSearchChanged),
          Expanded(
            child: BlocProvider(
              create: (context) {
                _cubit = di<DailyOfferCubit>()..getAllOffers(type: 'items');
                return _cubit!;
              },
              child: BlocBuilder<DailyOfferCubit, DailyOfferStates>(
                builder: (context, state) {
                  if (state is DailyOfferLoadingState) {
                    return const Center(child: AdaptiveProgressIndicator());
                  }
                  if (state is DailyOfferErrorState) {
                    return FailureComponent(
                      message: state.error,
                      onRetry: () {
                        final type = selectedId == 'items' ? 'items' : 'stores';
                        context.read<DailyOfferCubit>().getAllOffers(search: _currentSearch.isEmpty ? null : _currentSearch, type: type);
                      },
                    );
                  }
                  if (state is DailyOfferSuccessState || state is DailyOfferLoadingMoreState) {
                    final data = state is DailyOfferSuccessState
                        ? state.dailyOfferDataModel
                        : (state as DailyOfferLoadingMoreState).dailyOfferDataModel;
                    final pagination = state is DailyOfferSuccessState ? state.pagination : (state as DailyOfferLoadingMoreState).pagination;
                    final isLoadingMore = state is DailyOfferLoadingMoreState;
                    final items = data?.itemsWithOffers ?? const [];
                    final stores = data?.storesWithOffers ?? const [];
                    if (items.isEmpty && stores.isEmpty && !isLoadingMore) {
                      return Center(
                        child: Text(
                          _currentSearch.isEmpty ? L10n.tr().noData : L10n.tr().noSearchResults,
                          style: context.style14400.copyWith(fontWeight: TStyle.semi),
                        ),
                      );
                    }

                    return CustomScrollView(
                      controller: _scrollController,
                      cacheExtent: 100,
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: AppConst.smallPadding,
                            child: CustomSwitcher(
                              items: [
                                SwitcherItem(id: 'items', name: L10n.tr().items),
                                SwitcherItem(id: 'vendors', name: L10n.tr().vendors),
                              ],
                              selectedId: selectedId,
                              onChanged: onChanged,
                            ),
                          ),
                        ),
                        if (items.isNotEmpty) ...[
                          const SliverToBoxAdapter(child: VerticalSpacing(16)),

                          if (selectedId == 'items')
                            SliverPadding(
                              padding: AppConst.smallPadding,
                              sliver: SliverToBoxAdapter(
                                child: Wrap(
                                  runAlignment: WrapAlignment.spaceBetween,
                                  alignment: WrapAlignment.spaceBetween,
                                  runSpacing: 8,
                                  children: List.generate(items.length, (index) {
                                    final item = items[index];
                                    if (item.item == null || item.item!.store == null) {
                                      return const SizedBox.shrink();
                                    }
                                    return Container(
                                      width: (MediaQuery.sizeOf(context).width / 2) - 8,
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                      child: VerticalProductCard(key: ValueKey('item_${item.id}'), product: item.item!.toEntity(), canAdd: false),
                                    );
                                  }),
                                ),
                              ),
                            ),
                        ],
                        if (selectedId == 'vendors') ...[
                          if (stores.isNotEmpty) ...[
                            SliverPadding(
                              padding: AppConst.defaultPadding,
                              sliver: SliverToBoxAdapter(
                                child: Row(
                                  children: [
                                    GradientText(
                                      text: L10n.tr().storesOffersForYou,
                                      style: TStyle.robotBlackRegular().copyWith(fontWeight: TStyle.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SliverToBoxAdapter(child: VerticalSpacing(8)),
                            SliverPadding(
                              padding: AppConst.defaultPadding,
                              sliver: SliverGrid(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8,
                                ),
                                delegate: SliverChildBuilderDelegate((context, index) {
                                  final s = stores[index];
                                  final entity = ProductEntity(
                                    id: s.id ?? 0,
                                    sold: 0,

                                    productId: s.id,
                                    name: s.storeName ?? '',
                                    description: '',
                                    price: 0,
                                    image: s.image ?? '',
                                    rate: double.tryParse(s.rate ?? '0') ?? 0,
                                    reviewCount: (s.rateCount ?? 0).toInt(),
                                    outOfStock: false,
                                    offer: OfferEntity(
                                      id: s.offer?.id ?? 0,
                                      discount: (s.offer?.discount ?? 0).toDouble(),
                                      maxDiscount: s.offer?.maxDiscount ?? 0,

                                      discountType: DiscountType.fromString(s.offer?.discountType ?? ''),
                                    ),
                                  );
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: VerticalProductCard(
                                      key: ValueKey('store_${entity.id}'),
                                      product: entity,
                                      canAdd: false,
                                      onTap: () {
                                        log('id==> ${s.storeCategoryType}');
                                        if (s.id == null) {
                                          return;
                                        }

                                        if (s.storeCategoryType == VendorType.restaurant.value) {
                                          context.navigateToPage(
                                            BlocProvider(
                                              create: (context) => di<SingleRestaurantCubit>(param1: s.id),
                                              child: RestaurantDetailsScreen(id: s.id!),
                                            ),
                                          );
                                          context.navigateToPage(
                                            BlocProvider(
                                              create: (context) => di<StoreDetailsCubit>(param1: s.id),
                                              child: StoreDetailsScreen(storeId: s.id!),
                                            ),
                                          );
                                          // RestaurantDetailsScreen(
                                          //   id: s.id,
                                          // ).push(context);
                                        } else if (s.storeCategoryType == VendorType.grocery.value) {
                                          // context.push(StoreDetailsScreen.route, extra: {'store_id': s.id});
                                          context.navigateToPage(
                                            BlocProvider(
                                              create: (context) => di<StoreDetailsCubit>(param1: s.id),
                                              child: StoreDetailsScreen(storeId: s.id!),
                                            ),
                                          );
                                          // StoreDetailsRoute(
                                          //   storeId: s.id ?? -1,
                                          // ).push(context);
                                        } else {
                                          context.navigateToPage(
                                            BlocProvider(
                                              create: (context) => di<StoreDetailsCubit>(param1: s.id),
                                              child: StoreDetailsScreen(storeId: s.id!),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  );
                                }, childCount: stores.length),
                              ),
                            ),
                            const SliverToBoxAdapter(child: VerticalSpacing(16)),
                          ] else ...[
                            SliverToBoxAdapter(
                              child: Center(child: FailureComponent(message: L10n.tr().noData)),
                            ),
                          ],
                        ],
                        if (isLoadingMore)
                          const SliverToBoxAdapter(
                            child: Padding(padding: EdgeInsets.all(16.0), child: AdaptiveProgressIndicator()),
                          ),
                        if (pagination != null && !pagination.hasNext && (items.isNotEmpty || stores.isNotEmpty))
                          const SliverToBoxAdapter(
                            child: Padding(padding: EdgeInsets.all(16.0), child: SizedBox.shrink()),
                          ),
                      ],
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
