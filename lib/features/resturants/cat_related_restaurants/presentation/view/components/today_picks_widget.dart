part of "../cat_related_restaurants_screen.dart";

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
          child: GradientText(text: "Today's Picks", style: TStyle.blackBold(24)),
        ),
        SizedBox(
          height: 260,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: Fakers.vendors.length,
            padding: AppConst.defaultHrPadding,
            separatorBuilder: (context, index) => const HorizontalSpacing(16),
            itemBuilder: (context, index) {
              final vendor = Fakers.vendors[index];
              return SizedBox(
                width: 200,
                child: ClipRRect(
                  borderRadius: AppConst.defaultBorderRadius,
                  child: DecoratedBox(
                    decoration: BoxDecoration(gradient: Grad.bglightLinear),
                    child: InkWell(
                      onTap: () {
                        if (index.isEven) {
                          final widget = AppTransitions().slideTransition(
                            SingleCatRestaurantScreen(vendorId: vendor.id),
                            start: const Offset(1, 0),
                          );
                          AppNavigator().push(widget);
                        } else {
                          context.myPush(MultiCatRestaurantsScreen(vendorId: vendor.id));
                        }
                      },
                      child: Column(
                        spacing: 4,
                        children: [
                          Expanded(
                            child: SizedBox.expand(child: Image.asset(vendor.image, fit: BoxFit.cover)),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        DecoratedBox(
                                          decoration: const BoxDecoration(color: Color(0x1A4ECDC4)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              spacing: 8,
                                              children: [
                                                const Icon(Icons.star, size: 16, color: Co.second2),
                                                Text(vendor.rate.toStringAsFixed(1), style: TStyle.secondarySemi(13)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(Icons.access_time, color: Co.grey, size: 16),
                                            Text("25 m", style: TStyle.blackSemi(13)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Text.rich(
                                    TextSpan(
                                      children: [
                                        TextSpan(text: vendor.name, style: TStyle.blackBold(15)),
                                        const TextSpan(text: '\n'),
                                        TextSpan(text: vendor.deliveryTime, style: TStyle.secondarySemi(14)),
                                      ],
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GradientTextWzShadow(
                                        text: Helpers.getProperPrice(50.0),
                                        shadow: AppDec.blackTextShadow.first,
                                        style: TStyle.blackBold(14),
                                      ),
                                      const DecoratedFavoriteWidget(isDarkContainer: true, size: 18),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
