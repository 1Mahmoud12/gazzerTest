part of '../multi_cat_restaurant_screen.dart';

class _TopRatedComponent extends StatelessWidget {
  const _TopRatedComponent({required this.toprated, required this.isCardDisabled});
  final List<PlateEntity> toprated;
  final bool isCardDisabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(L10n.tr().topRated, style: context.style20500.copyWith(color: Co.purple)),
        ),
        const VerticalSpacing(8),
        SingleChildScrollView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.horizontal,
          child: Row(children: toprated.map((e) => _TopRatedCard(e)).toList()),
        ),
      ],
    );
  }
}
