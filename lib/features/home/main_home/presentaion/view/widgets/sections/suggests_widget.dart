import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/domain/entities/banner_entity.dart';
import 'package:gazzer/core/presentation/extensions/context.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/banners/main_banner_widget.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/horizontal_product_card.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/home/homeViewAll/suggested/presentation/view/suggested_screen.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/presentation/cubit/suggests_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/presentation/cubit/suggests_widget_states.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:go_router/go_router.dart';

class SuggestsWidget extends StatelessWidget {
  const SuggestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuggestsWidgetCubit, SuggestsWidgetStates>(
      buildWhen: (previous, current) {
        // Only rebuild if state type actually changed or data changed
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is SuggestsWidgetSuccessState && current is SuggestsWidgetSuccessState) {
          return previous.entities != current.entities || previous.banner != current.banner;
        }
        return false;
      },
      builder: (context, state) {
        if (state is SuggestsWidgetSuccessState) {
          return _SuggestsContent(items: state.entities, banner: state.banner);
        }
        /* else if (state is SuggestsWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (state is SuggestsWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }*/
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}

class _SuggestsContent extends StatelessWidget {
  const _SuggestsContent({required this.items, this.banner});

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
            title: L10n.tr().suggestedForYou,
            titleStyle: context.style20500.copyWith(color: Co.purple),
            onPressed: () {
              context.push(SuggestedScreen.route);
            },
          ),
          const VerticalSpacing(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(items.length > 10 ? 10 : items.length, (index) {
                if (items[index].store == null) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: HorizontalProductCard(product: items[index], width: MediaQuery.sizeOf(context).width * .65),
                );
              }),
            ),
          ),
          if (banner != null) ...[const VerticalSpacing(24), MainBannerWidget(banner: banner!)],
          const VerticalSpacing(24),
        ]),
      ),
    );
  }
}
