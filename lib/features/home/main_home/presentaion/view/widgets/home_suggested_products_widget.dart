part of '../home_screen.dart';

class _HomeSuggestedProductsWidget extends StatelessWidget {
  const _HomeSuggestedProductsWidget({required this.items});
  final List<GenericItemEntity?> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          TitleWithMore(
            title: L10n.tr().suggestedForYou,

            onPressed: () {
              context.push(SuggestedScreen.route);
            },
          ),
          const VerticalSpacing(12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(items.length > 4 ? 4 : items.length, (index) {
                if (items[index] == null || items[index]!.store == null) return const SizedBox.shrink();
                return HorizontalProductCard(product: items[index]!);
              }),
            ),
          ),
          const VerticalSpacing(24),
        ]),
      ),
    );
  }
}
