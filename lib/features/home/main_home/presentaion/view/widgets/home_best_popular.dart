part of '../home_screen.dart';

class _HomeBestPopular extends StatelessWidget {
  const _HomeBestPopular({required this.items});
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
              title: L10n.tr().bestPopular,
              onPressed: () {
                context.push(PopularScreen.route);
              },
            ),
            const VerticalSpacing(12),
            SizedBox(
              height: 240,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (context, index) => const HorizontalSpacing(12),
                itemBuilder: (context, index) {
                  final prod = items[index];
                  if (prod == null) return const SizedBox.shrink();
                  return VerticalRotatedImgCard(
                    prod: prod,
                    onTap: () {
                      PlateDetailsRoute(id: prod.id).push(context);
                    },
                  );
                },
              ),
            ),
            const VerticalSpacing(24),
          ],
        ),
      ),
    );
  }
}
