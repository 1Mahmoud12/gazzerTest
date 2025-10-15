import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_cubit.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_states.dart';
import 'package:gazzer/features/home/home_categories/common/home_categories_header.dart';
import 'package:gazzer/features/vendors/common/data/generic_item_dto.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/common/domain/offer_entity.dart';

class DailyOffersScreen extends StatelessWidget {
  const DailyOffersScreen({super.key});
  static const route = '/daily-offers';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false, iconsColor: Co.secondary),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeCategoriesHeader(),

          Expanded(
            child: BlocProvider(
              create: (context) => di<DailyOfferCubit>()..getAllOffers(),
              child: BlocBuilder<DailyOfferCubit, DailyOfferStates>(
                builder: (context, state) {
                  if (state is DailyOfferLoadingState) {
                    return const Center(child: AdaptiveProgressIndicator());
                  }
                  if (state is DailyOfferErrorState) {
                    return Center(
                      child: Text(state.error, style: TStyle.errorSemi(14)),
                    );
                  }
                  if (state is DailyOfferSuccessState) {
                    final data = state.dailyOfferDataModel;
                    final items = data?.itemsWithOffers ?? const [];
                    final stores = data?.storesWithOffers ?? const [];

                    if ((items.isEmpty) && (stores.isEmpty)) {
                      return Center(
                        child: Text(
                          L10n.tr().noData,
                          style: TStyle.mainwSemi(14),
                        ),
                      );
                    }

                    return ListView(
                      padding: AppConst.defaultPadding,
                      cacheExtent: 100,
                      children: [
                        if (stores.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GradientText(
                                text: L10n.tr().storesOffersForYou,
                                style: TStyle.blackBold(16),
                              ),
                            ],
                          ),
                          const VerticalSpacing(8),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.84,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: stores.length,
                            itemBuilder: (context, index) {
                              final s = stores[index];
                              final type = s.storeType;
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
                                  discountType: DiscountType.fromString(
                                    s.offer?.discountType ?? '',
                                  ),
                                ),
                              );
                              return VerticalProductCard(
                                key: ValueKey('store_${DateTime.now().millisecondsSinceEpoch}'),
                                product: entity,
                                canAdd: false,
                                onTap: () {
                                  // if (type == VendorType.restaurant.value) {
                                  //   RestaurantDetailsRoute(
                                  //     id: entity.id,
                                  //   ).push(context);
                                  // } else if (type == VendorType.grocery.value) {
                                  //   StoreDetailsRoute(
                                  //     storeId: entity.id,
                                  //   ).push(context);
                                  // } else {
                                  //   StoreDetailsRoute(
                                  //     storeId: entity.id,
                                  //   ).push(context);
                                  // }
                                },
                              );
                            },
                          ),
                          const VerticalSpacing(16),
                        ],

                        if (items.isNotEmpty) ...[
                          const VerticalSpacing(16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: AppConst.defaultHrPadding,
                                child: GradientText(
                                  text: L10n.tr().dailyOffersForYou,
                                  style: TStyle.blackBold(16),
                                ),
                              ),
                            ],
                          ),
                          const VerticalSpacing(16),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.84,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                            ),
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              final it = items[index];
                              final item = it.item;
                              if (item == null) return const SizedBox.shrink();
                              final price =
                                  double.tryParse(
                                    (item.appPrice ?? item.price ?? '0').toString(),
                                  ) ??
                                  0;

                              return VerticalProductCard(
                                product: ProductEntity(
                                  id: item.id!,
                                  name: item.name!,
                                  description: '',
                                  price: price,
                                  image: item.image!,
                                  rate: 0,
                                  reviewCount: 0,
                                  outOfStock: false,
                                  offer: OfferEntity(
                                    id: item.offer!.id!,
                                    discount: item.offer!.discount!.toDouble(),
                                    discountType: DiscountType.fromString(
                                      item.offer!.discountType ?? '',
                                    ),
                                  ),
                                  store: SimpleStoreEntity(
                                    id: item.storeInfo!.storeId!,
                                    name: item.storeInfo!.storeName!,
                                    image: item.storeInfo!.storeImage!,
                                    type: item.storeInfo!.storeCategoryType!,
                                  ),
                                ),
                                canAdd: false,
                              );
                            },
                          ),
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
