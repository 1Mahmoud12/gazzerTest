part of '../grocery_screen.dart';

class _TopRatedComponent extends StatelessWidget {
  const _TopRatedComponent({required this.subcat, required this.vendors});
  final CategoryOfPlateEntity subcat;
  final List<VendorModel> vendors;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        children: [
          TitleWithMore(title: subcat.name, onPressed: () {}),
          SizedBox(
            height: 140,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(16),
              itemBuilder: (context, index) {
                return VendorListTile(vendor: vendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VendorListTile extends StatelessWidget {
  const VendorListTile({super.key, required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 270,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(60)),
          gradient: Grad.bglightLinear.copyWith(colors: [Co.buttonGradient.withAlpha(60), Co.bg.withAlpha(0)]),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 16, 12),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ClipOval(
                  child: AspectRatio(aspectRatio: 1, child: Image.asset(vendor.image, fit: BoxFit.cover)),
                ),
              ),
              const HorizontalSpacing(12),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(vendor.name, style: TStyle.primaryBold(12))),
                        DecoratedFavoriteWidget(isDarkContainer: false, size: 16, borderRadius: AppConst.defaultInnerBorderRadius),
                      ],
                    ),
                    Expanded(
                      child: Text(vendor.description, style: TStyle.greyRegular(12), overflow: TextOverflow.ellipsis, maxLines: 3),
                    ),
                    AppRatingWidget(vendor.rate.toString(), itemSize: 18),
                    Row(
                      children: [
                        const Icon(Icons.access_time_rounded, color: Co.purple, size: 18),
                        Text(vendor.deliveryTime, style: TStyle.blackSemi(12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
