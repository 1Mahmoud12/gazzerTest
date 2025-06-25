part of '../cat_related_restaurants_screen.dart';

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
            itemCount: Fakers.vendors.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final vendor = Fakers.vendors[index];

              return SizedBox(
                width: 105,
                child: InkWell(
                  onTap: () {
                    print("Tapped on vendor: ${vendor.name}");
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
                    spacing: 12,
                    children: [
                      Expanded(
                        child: AspectRatio(aspectRatio: 1, child: Image.asset(vendor.image, fit: BoxFit.cover)),
                      ),
                      Text(
                        '${vendor.name}\n',
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
