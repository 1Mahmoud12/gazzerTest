part of '../home_screen.dart';

class _DailyOffersWidget extends StatelessWidget {
  const _DailyOffersWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        TitleWithMore(
          title: "Daily Offers For You",
          titleStyle: TStyle.primaryBold(16),
          onPressed: () {
            Navigator.of(context).push(AppTransitions().slideTransition(const DailyOffersScreen()));
          },
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.88,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return VerticalProductCard(product: Fakers.fakeProds[index], canAdd: false);
          },
        ),
      ],
    );
  }
}
