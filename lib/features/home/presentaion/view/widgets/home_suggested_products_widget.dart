part of "../home_screen.dart";

class _HomeSuggestedProductsWidget extends StatelessWidget {
  const _HomeSuggestedProductsWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        TitleWithMore(title: "Suggested For You", onPressed: () {}),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: 4,
          separatorBuilder: (context, index) => const VerticalSpacing(12),
          itemBuilder: (context, index) {
            return HorizontalProductCard(product: Fakers.fakeProds[index]);
          },
        ),
      ],
    );
  }
}
