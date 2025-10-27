part of '../home_screen.dart';

class _HomeBestPopularStoresWidget extends StatelessWidget {
  const _HomeBestPopularStoresWidget({required this.stores});

  final List<VendorEntity?> stores;

  @override
  Widget build(BuildContext context) {
    if (stores.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            TitleWithMore(
              title: L10n.tr().bestPopularStores,
              onPressed: () {
                context.navigateToPage(
                  BlocProvider(
                    create: (context) => di<BestPopularCubit>()..getBestPopularStores(),
                    child: const BestPopularScreen(),
                  ),
                );
              },
            ),
            const VerticalSpacing(12),
            SizedBox(
              height: 70,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: stores.length,
                separatorBuilder: (context, index) => const HorizontalSpacing(12),
                itemBuilder: (context, index) {
                  if (stores[index] == null) return const SizedBox.shrink();
                  final store = stores[index];
                  return InkWell(
                    onTap: () {
                      if (store.type == VendorType.restaurant.value) {
                        context.navigateToPage(
                          BlocProvider(
                            create: (context) => di<SingleRestaurantCubit>(
                              param1: store.storeId,
                            ),
                            child: RestaurantDetailsScreen(
                              id: store.storeId,
                            ),
                          ),
                        );
                      } else {
                        context.navigateToPage(
                          BlocProvider(
                            create: (context) => di<StoreDetailsCubit>(
                              param1: store.storeId,
                            ),
                            child: StoreDetailsScreen(
                              storeId: store.storeId,
                            ),
                          ),
                        );
                      }
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: Grad().shadowGrad(),
                        ),
                        borderRadius: BorderRadius.circular(66),
                        gradient: Grad().bgLinear.copyWith(
                          stops: const [0.0, 1],
                          colors: [const Color(0x55402788), Colors.transparent],
                        ),
                      ),
                      child: Row(
                        spacing: 6,
                        children: [
                          CircleGradientBorderedImage(image: store!.image),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                store.name,
                                style: TStyle.blackBold(12),
                                textAlign: TextAlign.center,
                              ),

                              if (store.totalOrders != null)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${L10n.tr().totalOrders}: ', style: TStyle.blackRegular(10)),
                                    const HorizontalSpacing(4),
                                    Text(
                                      store.totalOrders.toString(),
                                      style: TStyle.blackRegular(12),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                            ],
                          ),
                          const HorizontalSpacing(8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const VerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
