part of "../home_screen.dart";

class _HomeSuggestedProductsWidget extends StatelessWidget {
  const _HomeSuggestedProductsWidget({required this.items});
  final List<ProductItemEntity?> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        spacing: 12,
        children: [
          TitleWithMore(
            title: L10n.tr().suggestedForYou,
            onPressed: () {
              context.push(SuggestedScreen.route);
            },
          ),
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
        ],
      ),
    );
  }
}
