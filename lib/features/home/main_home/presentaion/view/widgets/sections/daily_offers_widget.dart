import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/vertical_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/dailyOffers/presentation/daily_offers_screen.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/presentation/cubit/daily_offers_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/presentation/cubit/daily_offers_widget_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:go_router/go_router.dart';

class DailyOffersWidget extends StatelessWidget {
  const DailyOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyOffersWidgetCubit, DailyOffersWidgetStates>(
      buildWhen: (previous, current) {
        // Only rebuild if state type actually changed or data changed
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is DailyOffersWidgetSuccessState && current is DailyOffersWidgetSuccessState) {
          return previous.entities != current.entities || previous.banner != current.banner;
        }
        return false;
      },
      builder: (context, state) {
        if (state is DailyOffersWidgetSuccessState) {
          return _DailyOffersContent(items: state.entities, banner: state.banner);
        }
        /*else if (state is DailyOffersWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (state is DailyOffersWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }*/
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _DailyOffersContent extends StatelessWidget {
  const _DailyOffersContent({required this.items, this.banner});

  final List<GenericItemEntity> items;
  final BannerEntity? banner;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TitleWithMore(
            title: L10n.tr().dailyOffersForYou,
            titleStyle: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
            onPressed: () {
              context.push(DailyOffersScreen.route);
            },
          ),
          const VerticalSpacing(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                items.length > 10 ? 10 : items.length,
                (index) => SizedBox(
                  width: MediaQuery.sizeOf(context).width * .55,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: VerticalProductCard(product: items[index], canAdd: false),
                  ),
                ),
              ),
            ),
          ),
          if (banner != null) ...[const VerticalSpacing(24), MainBannerWidget(banner: banner!)],
          const VerticalSpacing(24),
        ]),
      ),
    );
  }
}
