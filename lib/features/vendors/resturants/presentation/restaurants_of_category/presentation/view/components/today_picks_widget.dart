part of "../restaurants_of_category_screen.dart";

class _TodayPicksWidget extends StatelessWidget {
  const _TodayPicksWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: GradientText(text: L10n.tr().todayPicks, style: TStyle.blackBold(24)),
        ),
        RestHorzScrollVertCardListComponent(
          title: L10n.tr().todayPicks,
          items: Fakers().restaurants,
          onViewAllPressed: null,
        ),
      ],
    );
  }
}
