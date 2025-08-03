part of '../home_screen.dart';

class _HomeBestPopular extends StatelessWidget {
  const _HomeBestPopular({required this.items});
  final List<GenericItemEntity?> items;

  @override
  Widget build(BuildContext context) {
    print('_HomeBestPopular is rendered');
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
              height: 180,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
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
