import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_cubit.dart';
import 'package:gazzer/features/home/best_popular/presentation/cubit/best_popular_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BestPopularScreen extends StatelessWidget {
  const BestPopularScreen({super.key});

  static const route = '/best-popular-stores';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showCart: false,
        iconsColor: Co.secondary,
        title: L10n.tr().bestPopularStores,
      ),
      body: BlocProvider(
        create: (context) => di<BestPopularCubit>()..getBestPopularStores(),
        child: BlocBuilder<BestPopularCubit, BestPopularStates>(
          builder: (context, state) {
            if (state is BestPopularLoadingState) {
              return _buildLoadingState();
            }
            if (state is BestPopularErrorState) {
              return FailureComponent(
                message: state.error,
                onRetry: () => context.read<BestPopularCubit>().getBestPopularStores(),
              );
            }
            if (state is BestPopularSuccessState) {
              final stores = state.stores;

              if (stores.isEmpty) {
                return Center(
                  child: Text(
                    L10n.tr().noData,
                    style: TStyle.mainwSemi(14),
                  ),
                );
              }

              return GridView.builder(
                padding: AppConst.defaultPadding,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                ),
                itemCount: stores.length,
                itemBuilder: (context, index) {
                  final vendor = stores[index];
                  return _VendorCard(vendor: vendor);
                },
              );
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
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
      ),
      itemCount: 12,
      itemBuilder: (context, index) {
        return const _VendorCardSkeleton();
      },
    );
  }
}

class _VendorCard extends StatelessWidget {
  const _VendorCard({required this.vendor});

  final VendorEntity vendor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToVendor(context),
      borderRadius: BorderRadius.circular(12),
      child: Column(
        spacing: 8,
        children: [
          Expanded(
            child: ClipOval(
              child: CustomNetworkImage(
                vendor.image,
                fit: BoxFit.cover,
                width: 80,
                height: 80,
              ),
            ),
          ),
          Text(
            vendor.name,
            style: TStyle.blackBold(12),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
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
      child: Column(
        spacing: 8,
        children: [
          Expanded(
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Container(
            width: 60,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}
