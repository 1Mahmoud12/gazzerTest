part of '../home_screen.dart';

class _DailyOffersWidget extends StatelessWidget {
  const _DailyOffersWidget({required this.items});
  final List<GenericItemEntity?> items;
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
              context.push(DailyOffersScreen.route, extra: {'items': items});
            },
          ),
          const VerticalSpacing(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                items.length > 10 ? 10 : items.length,
                (index) => SizedBox(width: 220, child: VerticalProductCard(product: items[index]!, canAdd: false)),
              ),
            ),
          ),

          const VerticalSpacing(24),
        ]),
      ),
    );
  }
}
