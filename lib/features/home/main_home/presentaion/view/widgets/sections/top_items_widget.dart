import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_rotated_img_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/home_categories/top_items_widget/presentation/cubit/top_items_widget_cubit.dart';
import 'package:gazzer/features/home/home_categories/top_items_widget/presentation/cubit/top_items_widget_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:go_router/go_router.dart';

class TopItemsWidget extends StatelessWidget {
  const TopItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopItemsWidgetCubit, TopItemsWidgetState>(
      builder: (context, state) {
        if (state is TopItemsWidgetSuccessState) {
          final items = state.items;
          if (items.isEmpty) {
            return const SliverToBoxAdapter(child: SizedBox.shrink());
          }
          return _TopItemsContent(items: items, banner: state.banner);
        } else if (state is TopItemsWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (state is TopItemsWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _TopItemsContent extends StatelessWidget {
  const _TopItemsContent({required this.items, this.banner});

  final List<GenericItemEntity> items;
  final BannerEntity? banner;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TitleWithMore(
            title: L10n.tr().bestPopular,
            onPressed: () {
              context.push(PopularScreen.route);
            },
          ),
          const VerticalSpacing(12),
          SizedBox(
            height: 150,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(12),
              itemBuilder: (context, index) {
                final prod = items[index];
                return VerticalRotatedImgCard(
                  prod: prod,
                  onTap: () {
                    if (prod is PlateEntity) {
                      PlateDetailsRoute(id: prod.id).push(context);
                    } else if (prod is ProductEntity) {
                      ProductDetailsRoute(productId: prod.id).push(context);
                    }
                  },
                );
              },
            ),
          ),
          if (banner != null) ...[const VerticalSpacing(24), MainBannerWidget(banner: banner!)],
          const VerticalSpacing(24),
        ]),
      ),
    );
  }
}
