part of '../grocery_screen.dart';

class _CategoryComponenetFive extends StatelessWidget {
  const _CategoryComponenetFive({required this.subcat, required this.vendors});
  final CategoryOfPlateEntity subcat;
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
            height: 170,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(24),
              itemBuilder: (context, index) {
                return _VendorCardFive(vendor: vendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorCardFive extends StatelessWidget {
  const _VendorCardFive({required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        spacing: 12,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                const AspectRatio(
                  aspectRatio: 1,

                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      boxShadow: [BoxShadow(spreadRadius: 0, blurRadius: 4, color: Colors.black12, offset: Offset(0, 4))],
                      color: Co.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),

                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: Image.asset(vendor.id.isEven ? Assets.assetsPngDrinks : Assets.assetsPngDrink2, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
          Text(vendor.name, style: TStyle.blackBold(12)),
        ],
      ),
    );
  }
}
