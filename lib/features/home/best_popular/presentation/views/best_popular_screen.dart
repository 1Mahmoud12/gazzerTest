import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/assets.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/vector_graphics_widget.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_cubit.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_vendor_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestPopularScreen extends StatefulWidget {
  const BestPopularScreen({super.key});

  static const route = '/best-popular-stores';

  @override
  State<BestPopularScreen> createState() => _BestPopularScreenState();
}

class _BestPopularScreenState extends State<BestPopularScreen> {
  final ScrollController _scrollController = ScrollController();
  BestPopularCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = _cubit;
      if (cubit != null) {
        final currentState = cubit.state;
        if (cubit.hasMore && currentState is! BestPopularLoadingMoreState) {
          cubit.getBestPopularStores(loadMore: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(showCart: false, iconsColor: Co.secondary, title: L10n.tr().bestPopularStores),
      body: BlocProvider(
        create: (context) {
          final cubit = di<BestPopularCubit>()..getBestPopularStores();
          _cubit = cubit;
          return cubit;
        },
        child: BlocBuilder<BestPopularCubit, BestPopularStates>(
          builder: (context, state) {
            if (state is BestPopularLoadingState) {
              return _buildLoadingState();
            }
            if (state is BestPopularErrorState) {
              return FailureComponent(message: state.error, onRetry: () => context.read<BestPopularCubit>().getBestPopularStores());
            }
            if (state is BestPopularSuccessState) {
              final stores = state.stores;
              final pagination = state.pagination;

              if (stores.isEmpty) {
                return Center(
                  child: Text(L10n.tr().noData, style: context.style14400.copyWith(fontWeight: TStyle.semi)),
                );
              }

              return _buildStoresGrid(stores, pagination);
            }

            if (state is BestPopularLoadingMoreState) {
              return _buildStoresGrid(state.stores, state.pagination, isLoadingMore: true);
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

  Widget _buildStoresGrid(List<StoreEntity> stores, PaginationInfo? pagination, {bool isLoadingMore = false}) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: AppConst.defaultPadding,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: stores.length,
            itemBuilder: (context, index) {
              final store = stores[index];
              return InkWell(
                onTap: () => _navigateToVendor(context, store),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    spacing: 4,
                    children: [
                      Expanded(
                        child: CustomNetworkImage(store.image, fit: BoxFit.cover, width: double.infinity, height: 120, borderRaduis: 12),
                      ),
                      Text(store.name, style: context.style16400, overflow: TextOverflow.ellipsis, maxLines: 1, textAlign: TextAlign.center),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 4,
                        children: [
                          const VectorGraphicsWidget(Assets.clockIc, height: 24, width: 24),
                          Text(
                            '${store.estimatedDeliveryTime} ${L10n.tr().min}',
                            style: TStyle.robotBlackThin().copyWith(color: Co.darkGrey, fontWeight: TStyle.regular),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          if (isLoadingMore) const Padding(padding: EdgeInsets.all(16.0), child: AdaptiveProgressIndicator()),
          if (pagination != null && !pagination.hasNext && stores.isNotEmpty) const Padding(padding: EdgeInsets.all(16.0), child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

void _navigateToVendor(BuildContext context, StoreEntity store) {
  if (store.storeCategoryType == VendorType.restaurant.value) {
    context.navigateToPage(
      BlocProvider(
        create: (context) => di<SingleRestaurantCubit>(param1: store.id),
        child: RestaurantDetailsScreen(id: store.id),
      ),
    );
  } else if (store.storeCategoryType == VendorType.grocery.value) {
    context.navigateToPage(
      BlocProvider(
        create: (context) => di<StoreDetailsCubit>(param1: store.id),
        child: StoreDetailsScreen(storeId: store.id),
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
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
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
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: 80,
                      height: 12,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
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
