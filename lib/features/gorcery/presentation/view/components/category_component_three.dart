part of '../grocery_screen.dart';

class CategoryComponentThree extends StatelessWidget {
  const CategoryComponentThree({super.key, required this.subcat, required this.vendors});
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

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: vendors.length > 6 ? 6 : vendors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // childAspectRatio: 0.62,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              mainAxisExtent: 290,
            ),
            itemBuilder: (context, index) {
              return _VendorCardThree(vendor: vendors[index]);
            },
          ),
        ],
      ),
    );
  }
}

class _VendorCardThree extends StatelessWidget {
  const _VendorCardThree({required this.vendor});
  final RestaurantEntity vendor;
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        // color: Co.red,
        border: GradientBoxBorder(gradient: Grad().shadowGrad()),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConst.defaultRadius),
          bottomRight: Radius.circular(AppConst.defaultRadius),
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
        ),
      ),
      child: Column(
        children: [
          ClipOval(
            child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(vendor.image, height: double.infinity, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 4,
                children: [
                  Expanded(child: Text(vendor.name, style: TStyle.primaryBold(14))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  ),
                  const SizedBox.shrink(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.access_time_rounded, size: 22, color: Co.purple),
                        Text(vendor.estimateDeliveryTime, style: TStyle.greyRegular(13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
