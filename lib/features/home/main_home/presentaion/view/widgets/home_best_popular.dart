part of '../home_screen.dart';

class _HomeBestPopular extends StatelessWidget {
  const _HomeBestPopular({required this.items});
  final List<GenericItemEntity?> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        children: [
          TitleWithMore(
            title: L10n.tr().bestPopular,
            onPressed: () {
              context.push(PopularScreen.route);
            },
          ),

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
        ],
      ),
    );
  }
}
