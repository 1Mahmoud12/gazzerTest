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
import 'package:gazzer/features/home/top_vendors/presentation/cubit/top_vendors_cubit.dart';
import 'package:gazzer/features/home/top_vendors/presentation/cubit/top_vendors_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TopVendorsScreen extends StatelessWidget {
  const TopVendorsScreen({super.key});

  static const route = '/top-vendors';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        showCart: false,
        iconsColor: Co.secondary,
        title: L10n.tr().topVendors,
      ),
      body: BlocProvider(
        create: (context) => di<TopVendorsCubit>()..getTopVendors(),
        child: BlocBuilder<TopVendorsCubit, TopVendorsStates>(
          builder: (context, state) {
            if (state is TopVendorsLoadingState) {
              return _buildLoadingState();
            }
            if (state is TopVendorsErrorState) {
              return FailureComponent(
                message: state.error,
                onRetry: () => context.read<TopVendorsCubit>().getTopVendors(),
              );
            }
            if (state is TopVendorsSuccessState) {
              final vendors = state.vendors;

              if (vendors.isEmpty) {
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
                itemCount: vendors.length,
                itemBuilder: (context, index) {
                  final vendor = vendors[index];
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
          create: (context) => di<SingleRestaurantCubit>(param1: vendor.id),
          child: RestaurantDetailsScreen(id: vendor.id),
        ),
      );
    } else if (vendor.type == VendorType.grocery.value) {
      context.navigateToPage(
        BlocProvider(
          create: (context) => di<StoreDetailsCubit>(param1: vendor.id),
          child: StoreDetailsScreen(storeId: vendor.id),
        ),
      );
    } else {
      context.navigateToPage(
        BlocProvider(
          create: (context) => di<StoreDetailsCubit>(param1: vendor.id),
          child: StoreDetailsScreen(storeId: vendor.id),
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
