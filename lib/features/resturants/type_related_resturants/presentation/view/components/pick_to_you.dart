part of '../type_related_restaurants_screen.dart';

class _PickToYou extends StatelessWidget {
  const _PickToYou();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: AppConst.defaultHrPadding,
          child: GradientText(text: "Pick To You", style: TStyle.blackBold(24)),
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: Fakers.fakeProds.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final prod = Fakers.fakeProds[index];

              return SizedBox(
                width: 105,
                child: InkWell(
                  onTap: () {
                    context.myPush(FoodDetailsScreen(product: prod));
                  },
                  child: Column(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: AspectRatio(aspectRatio: 1, child: Image.asset(prod.image, fit: BoxFit.cover)),
                      ),
                      Text(
                        '${prod.name}\n',
                        style: TStyle.blackSemi(14),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
