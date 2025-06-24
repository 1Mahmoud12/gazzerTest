part of '../home_screen.dart';

class _HomeBestPopular extends StatelessWidget {
  const _HomeBestPopular();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleWithMore(
          title: "Best Popular",
          onPressed: () {
            Navigator.of(context).push(AppTransitions().slideTransition(const PopularScreen()));
          },
        ),

        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final prod = Fakers.fakeProds[index];
              return VerticalRotatedImgCard(prod: prod);
            },
          ),
        ),
      ],
    );
  }
}
