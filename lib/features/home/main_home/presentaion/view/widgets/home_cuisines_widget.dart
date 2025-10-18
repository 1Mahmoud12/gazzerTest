part of '../home_screen.dart';

class _HomeTopVendorsWidget extends StatelessWidget {
  const _HomeTopVendorsWidget({required this.vendors});
  final List<VendorEntity?> vendors;
  @override
  Widget build(BuildContext context) {
    if (vendors.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            TitleWithMore(
              title: L10n.tr().topVendors,
              onPressed: () {
                context.push(TopVendorsScreen.route);
              },
            ),
            const VerticalSpacing(12),
            SizedBox(
              height: 70,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: vendors.length > 6 ? 4 : vendors.length,
                separatorBuilder: (context, index) => const HorizontalSpacing(12),
                itemBuilder: (context, index) {
                  if (vendors[index] == null) return const SizedBox.shrink();
                  final vendor = vendors[index];
                  return InkWell(
                    onTap: () {
                      // if (vendor.type == VendorType.restaurant.value) {
                      //   context.navigateToPage(
                      //     BlocProvider(
                      //       create: (context) => di<SingleRestaurantCubit>(
                      //         param1: vendor.id,
                      //       ),
                      //       child: RestaurantDetailsScreen(
                      //         id: vendor.id,
                      //       ),
                      //     ),
                      //   );
                      //   context.navigateToPage(
                      //     BlocProvider(
                      //       create: (context) => di<StoreDetailsCubit>(
                      //         param1: vendor.id,
                      //       ),
                      //       child: StoreDetailsScreen(
                      //         storeId: vendor.id,
                      //       ),
                      //     ),
                      //   );
                      //   // RestaurantDetailsScreen(
                      //   //   id: vendor.id,
                      //   // ).push(context);
                      // } else if (vendor.type == VendorType.grocery.value) {
                      //   // context.push(StoreDetailsScreen.route, extra: {'store_id': vendor.id});
                      //   context.navigateToPage(
                      //     BlocProvider(
                      //       create: (context) => di<StoreDetailsCubit>(
                      //         param1: vendor.id,
                      //       ),
                      //       child: StoreDetailsScreen(
                      //         storeId: vendor.id,
                      //       ),
                      //     ),
                      //   );
                      //   // StoreDetailsRoute(
                      //   //   storeId: vendor.id ?? -1,
                      //   // ).push(context);
                      // } else {
                      //   context.navigateToPage(
                      //     BlocProvider(
                      //       create: (context) => di<StoreDetailsCubit>(
                      //         param1: vendor.id,
                      //       ),
                      //       child: StoreDetailsScreen(
                      //         storeId: vendor.id,
                      //       ),
                      //     ),
                      //   );
                      // }
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
                          CircleGradientBorderedImage(image: vendor!.image),
                          Text(
                            vendor.name,
                            style: TStyle.blackBold(12),
                            textAlign: TextAlign.center,
                          ),
                          const HorizontalSpacing(8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const VerticalSpacing(12),
            if (vendors.length > 6) ...[
              const SizedBox.shrink(),
              SizedBox(
                height: 95,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: (vendors.length - 4) > 6 ? 6 : (vendors.length - 4),
                  separatorBuilder: (context, index) => const HorizontalSpacing(12),
                  itemBuilder: (context, index) {
                    if (vendors[index + 4] == null) return const SizedBox.shrink();
                    final cuisne = vendors[index + 4];
                    return InkWell(
                      onTap: () {
                        if (cuisne.id == null) {
                          return;
                        }

                        if (cuisne.type == VendorType.restaurant.value) {
                          context.navigateToPage(
                            BlocProvider(
                              create: (context) => di<SingleRestaurantCubit>(
                                param1: cuisne.id,
                              ),
                              child: RestaurantDetailsScreen(
                                id: cuisne.id,
                              ),
                            ),
                          );
                          context.navigateToPage(
                            BlocProvider(
                              create: (context) => di<StoreDetailsCubit>(
                                param1: cuisne.id,
                              ),
                              child: StoreDetailsScreen(
                                storeId: cuisne.id,
                              ),
                            ),
                          );
                          // RestaurantDetailsScreen(
                          //   id: cuisne.id,
                          // ).push(context);
                        } else if (cuisne.type == VendorType.grocery.value) {
                          // context.push(StoreDetailsScreen.route, extra: {'store_id': cuisne.id});
                          context.navigateToPage(
                            BlocProvider(
                              create: (context) => di<StoreDetailsCubit>(
                                param1: cuisne.id,
                              ),
                              child: StoreDetailsScreen(
                                storeId: cuisne.id,
                              ),
                            ),
                          );
                          // StoreDetailsRoute(
                          //   storeId: cuisne.id ?? -1,
                          // ).push(context);
                        } else {
                          context.navigateToPage(
                            BlocProvider(
                              create: (context) => di<StoreDetailsCubit>(
                                param1: cuisne.id,
                              ),
                              child: StoreDetailsScreen(
                                storeId: cuisne.id,
                              ),
                            ),
                          );
                        }
                      },
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 110),
                        child: Column(
                          spacing: 8,
                          children: [
                            Expanded(
                              child: CircleGradientBorderedImage(
                                image: cuisne!.image,
                              ),
                            ),
                            Text(
                              cuisne.name,
                              style: TStyle.blackBold(12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],

            // const VerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
