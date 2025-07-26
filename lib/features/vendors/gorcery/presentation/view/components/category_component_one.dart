part of '../grocery_screen.dart';

class CategoryComponentOne extends StatelessWidget {
  const CategoryComponentOne({super.key, required this.subcat, required this.vendors});
  final CategoryOfPlateEntity subcat;
  final List<RestaurantEntity> vendors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        spacing: 24,
        children: [
          TitleWithMore(
            title: subcat.name,
            onPressed: () {
              // nav to subcat id;
            },
          ),

          SizedBox(
            height: 270,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(16),
              itemBuilder: (context, index) {
                return _VendorCardOne(vendor: vendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorCardOne extends StatelessWidget {
  const _VendorCardOne({required this.vendor});
  final RestaurantEntity vendor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        children: [
          Expanded(
            child: DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                borderRadius: AppConst.defaultBorderRadius,
                border: GradientBoxBorder(gradient: Grad().shadowGrad()),
              ),
              child: ClipRRect(
                borderRadius: AppConst.defaultBorderRadius,
                child: Image.asset(vendor.image, height: double.infinity, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
          ),
          Expanded(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: Grad().bglightLinear),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(vendor.name, style: TStyle.blackBold(14)),
                    Expanded(
                      child: Text(
                        vendor.address ?? '',
                        style: TStyle.greyRegular(13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    Row(
                      spacing: 18,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.star, size: 24, color: Co.secondary),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: vendor.rate.toStringAsFixed(1), style: TStyle.secondaryBold(13)),
                              TextSpan(text: "  ( ${vendor.reviewCount} )", style: TStyle.greyBold(13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      spacing: 18,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time_rounded, size: 22, color: Co.purple),

                        Text(vendor.deliveryTime ?? '', style: TStyle.greyRegular(13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
