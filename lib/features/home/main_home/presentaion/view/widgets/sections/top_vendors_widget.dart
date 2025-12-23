import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_colors.dart';
import 'package:gazzer/core/presentation/theme/text_style.dart';
import 'package:gazzer/core/presentation/utils/navigate.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/custom_network_image.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/presentation/top_vendors_screen.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/presentation/cubit/top_vendors_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/presentation/cubit/top_vendors_widget_states.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/single_restaurant_cubit.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/sotre_details_cubit.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';
import 'package:go_router/go_router.dart';

class TopVendorsWidget extends StatelessWidget {
  const TopVendorsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopVendorsWidgetCubit, TopVendorsWidgetState>(
      builder: (context, state) {
        if (state is TopVendorsWidgetSuccessState) {
          final vendors = state.vendors;
          if (vendors.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return _TopVendorsContent(vendors: vendors, banner: state.banner);
        } else if (state is TopVendorsWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (state is TopVendorsWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _TopVendorsContent extends StatelessWidget {
  const _TopVendorsContent({required this.vendors, this.banner});

  final List<VendorEntity> vendors;
  final BannerEntity? banner;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TitleWithMore(
            title: L10n.tr().topVendors,
            titleStyle: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
            onPressed: () {
              context.push(TopVendorsScreen.route);
            },
          ),
          const VerticalSpacing(12),
          SizedBox(
            height: 140,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length > 10 ? 10 : vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final vendor = vendors[index];
                return InkWell(
                  onTap: () {
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
                    } else if (vendor.type == VendorType.pharmacy.value) {
                      PharmacyStoreScreenRoute(id: vendor.id).push(context);
                    } else {
                      context.navigateToPage(
                        BlocProvider(
                          create: (context) => di<StoreDetailsCubit>(param1: vendor.storeId),
                          child: StoreDetailsScreen(storeId: vendor.storeId),
                        ),
                      );
                    }
                  },
                  child: Column(
                    spacing: 8,
                    children: [
                      CustomNetworkImage(vendor.image, fit: BoxFit.cover, width: 120, height: 100, borderRaduis: 12),
                      SizedBox(
                        width: 100,
                        child: Text(
                          vendor.name,
                          style: TStyle.robotBlackRegular(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          if (banner != null) ...[const VerticalSpacing(24), MainBannerWidget(banner: banner!)],
          const VerticalSpacing(12),
        ]),
      ),
    );
  }
}
