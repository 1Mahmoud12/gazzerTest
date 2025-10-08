part of "../home_screen.dart";

class _HomeSuggestedProductsWidget extends StatelessWidget {
  const _HomeSuggestedProductsWidget({required this.items});
  final List<GenericItemEntity?> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());

    return SliverPadding(
      padding: AppConst.defaultHrPadding,
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            TitleWithMore(
              title: L10n.tr().suggestedForYou,
              onPressed: () {
                context.push(SuggestedScreen.route);
              },
            ),
            const VerticalSpacing(12),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: items.length > 4 ? 4 : items.length,
              separatorBuilder: (context, index) => const VerticalSpacing(12),
              itemBuilder: (context, index) {
                if (items[index] == null) return const SizedBox.shrink();

                return HorizontalProductCard(product: items[index]!);
              },
            ),
            const VerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
