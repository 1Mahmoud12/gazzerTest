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
        delegate: SliverChildListDelegate(
          [
            TitleWithMore(
              title: L10n.tr().dailyOffersForYou,
              titleStyle: TStyle.primaryBold(16),
              onPressed: () {
                context.push(DailyOffersScreen.route, extra: {'items': items});
                // DailyOffersScreen().pu;
              },
            ),
            const VerticalSpacing(12),

            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,

              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.77,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: items.length > 4 ? 4 : items.length,
              itemBuilder: (context, index) {
                if (items[index] == null) return const SizedBox.shrink();
                return VerticalProductCard(
                  product: items[index]!,
                  canAdd: false,
                );
              },
            ),
            const VerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
