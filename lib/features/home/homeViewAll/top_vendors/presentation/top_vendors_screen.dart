import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/presentation/cubit/top_vendors_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/presentation/cubit/top_vendors_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopVendorsScreen extends StatefulWidget {
  const TopVendorsScreen({super.key});

  static const route = '/top-vendors';

  @override
  State<TopVendorsScreen> createState() => _TopVendorsScreenState();
}

class _TopVendorsScreenState extends State<TopVendorsScreen> {
  final ScrollController _scrollController = ScrollController();
  TopVendorsCubit? _cubit;

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
        if (cubit.hasMore && currentState is! TopVendorsLoadingMoreState) {
          cubit.getTopVendors(loadMore: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(iconsColor: Co.secondary, title: L10n.tr().topVendors),
      body: BlocProvider(
        create: (context) {
          final cubit = di<TopVendorsCubit>()..getTopVendors();
          _cubit = cubit;
          return cubit;
        },
        child: BlocBuilder<TopVendorsCubit, TopVendorsStates>(
          builder: (context, state) {
            if (state is TopVendorsLoadingState) {
              return _buildLoadingState();
            }
            if (state is TopVendorsErrorState) {
              return FailureComponent(message: state.error, onRetry: () => context.read<TopVendorsCubit>().getTopVendors());
            }
            if (state is TopVendorsSuccessState) {
              final vendors = state.vendors;
              final pagination = state.pagination;

              if (vendors.isEmpty) {
                return Center(
                  child: Text(L10n.tr().noData, style: context.style14400.copyWith(fontWeight: TStyle.semi)),
                );
              }

              return _buildVendorsGrid(vendors, pagination);
            }

            if (state is TopVendorsLoadingMoreState) {
              return _buildVendorsGrid(state.vendors, state.pagination, isLoadingMore: true);
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
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return const _VendorCardSkeleton();
      },
    );
  }

  Widget _buildVendorsGrid(List<VendorEntity> vendors, PaginationInfo? pagination, {bool isLoadingMore = false}) {
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
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return _VendorCard(vendor: vendor);
            },
          ),
          if (isLoadingMore) const Padding(padding: EdgeInsets.all(16.0), child: AdaptiveProgressIndicator()),
          if (pagination != null && !pagination.hasNext && vendors.isNotEmpty) const Padding(padding: EdgeInsets.all(16.0), child: SizedBox.shrink()),
        ],
      ),
    );
  }
}

class _VendorCard extends StatelessWidget {
  const _VendorCard({required this.vendor});

  final VendorEntity vendor;

  @override
  Widget build(BuildContext context) {
    return Skeleton.leaf(
      child: InkWell(
        onTap: () => _navigateToVendor(context),
        borderRadius: AppConst.defaultInnerBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            spacing: 4,
            children: [
              Expanded(
                child: CustomNetworkImage(vendor.image, fit: BoxFit.cover, width: double.infinity, height: 120, borderRaduis: 12),
              ),
              Text(vendor.name, style: TStyle.robotBlackRegular(), overflow: TextOverflow.ellipsis, maxLines: 1),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToVendor(BuildContext context) {
    if (vendor.type == VendorType.restaurant.value) {
      context.navigateToPage(
        BlocProvider(
          create: (context) => di<SingleRestaurantCubit>(param1: vendor.storeId),
          child: RestaurantDetailsScreen(id: vendor.storeId),
        ),
      );
    } else if (vendor.type == VendorType.grocery.value) {
      context.navigateToPage(
        BlocProvider(
          create: (context) => di<StoreDetailsCubit>(param1: vendor.storeId),
          child: StoreDetailsScreen(storeId: vendor.storeId),
        ),
      );
    } else {
      context.navigateToPage(
        BlocProvider(
          create: (context) => di<StoreDetailsCubit>(param1: vendor.storeId),
          child: StoreDetailsScreen(storeId: vendor.storeId),
        ),
      );
    }
  }
}

class _VendorCardSkeleton extends StatelessWidget {
  const _VendorCardSkeleton();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: Grad().bglightLinear, borderRadius: AppConst.defaultInnerBorderRadius),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(
                spacing: 12,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 4,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        ),
                        Container(
                          width: 80,
                          height: 12,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: 60,
                height: 24,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
