part of '../restaurants_of_category_screen.dart';

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
          child: GradientText(text: L10n.tr().pickToYou, style: TStyle.blackBold(24)),
        ),
        SizedBox(
          height: 130,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: Fakers.restaurants.length,
            separatorBuilder: (context, index) => const HorizontalSpacing(12),
            itemBuilder: (context, index) {
              final vendor = Fakers.restaurants[index];

              return SizedBox(
                width: 105,
                child: InkWell(
                  onTap: () {
                    if (vendor.id.isEven) {
                      SingleCatRestaurantRoute(id: vendor.id).push(context);
                    } else {
                      MultiCatRestaurantsRoute(id: vendor.id).push(context);
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
