part of '../grocery_screen.dart';

class _CategoryComponenetFour extends StatelessWidget {
  const _CategoryComponenetFour({required this.subcat, required this.vendors});
  final SubcategoryModel subcat;
  final List<VendorModel> vendors;
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
            height: 240,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(16),
              itemBuilder: (context, index) {
                return _VendorCardFour(vendor: vendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorCardFour extends StatelessWidget {
  const _VendorCardFour({required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                border: GradientBoxBorder(gradient: Grad.shadowGrad()),
              ),
              child: Image.asset(vendor.image, height: double.infinity, width: double.infinity, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vendor.name, style: TStyle.primaryBold(14)),
                  Expanded(
                    child: Text(vendor.description, style: TStyle.greyRegular(13), overflow: TextOverflow.ellipsis, maxLines: 3),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 18,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
