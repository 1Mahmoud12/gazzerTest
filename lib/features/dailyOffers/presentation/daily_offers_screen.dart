import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    // Cancel previous timer
    _debounceTimer?.cancel();

    // Create new timer for debouncing
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (_currentSearch != value) {
        _currentSearch = value;
        _cubit?.getAllOffers(search: value.isEmpty ? null : value);
      }
    });
  }

  String selectedId = 'items';

  void onChanged(String id) {
    setState(() {
      selectedId = id;
    });
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
                _cubit = di<DailyOfferCubit>()..getAllOffers();
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
                      onRetry: () => context.read<DailyOfferCubit>().getAllOffers(search: _currentSearch.isEmpty ? null : _currentSearch),
                    );
                  }
                  if (state is DailyOfferSuccessState) {
                    final data = state.dailyOfferDataModel;
                    final items = data?.itemsWithOffers ?? const [];
                    final stores = data?.storesWithOffers ?? const [];
                    if (items.isEmpty && stores.isEmpty) {
                      return Center(child: Text(_currentSearch.isEmpty ? L10n.tr().noData : L10n.tr().noSearchResults, style: TStyle.mainwSemi(14)));
                    }

                    return CustomScrollView(
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
                              sliver: SliverGrid(
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.68,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 8,
                                ),
                                delegate: SliverChildBuilderDelegate((context, index) {
                                  final item = items[index];
                                  if (item.item == null || item.item!.store == null) return const SizedBox.shrink();
                                  return VerticalProductCard(key: ValueKey('item_${item.id}'), product: item.item!.toEntity(), canAdd: false);
                                }, childCount: items.length),
                              ),
                            ),
                        ],
                        if (selectedId == 'vendors') ...[
                          if (stores.isNotEmpty) ...[
                            SliverPadding(
                              padding: AppConst.defaultPadding,
                              sliver: SliverToBoxAdapter(
                                child: Row(
                                  children: [GradientText(text: L10n.tr().storesOffersForYou, style: TStyle.blackBold(16))],
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
                                  return VerticalProductCard(
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
