part of '../grocery_screen.dart';

class CategoryComponentTwo extends StatelessWidget {
  const CategoryComponentTwo({super.key, required this.subcat, required this.vendors});
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
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: vendors.length,
              separatorBuilder: (context, index) => const HorizontalSpacing(16),
              itemBuilder: (context, index) {
                return _VendorCardTwo(vendor: vendors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorCardTwo extends StatelessWidget {
  const _VendorCardTwo({required this.vendor});
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    final corner = Corner.values[vendor.id % 4];
    return InkWell(
      onTap: () {},
      borderRadius: AppConst.defaultBorderRadius,
      child: SizedBox(
        width: 165,
        child: Column(
          spacing: 4,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CustomPaint(
                      isComplex: true,
                      foregroundPainter: CornerIndendetShape(indent: const Size(36, 36), corner: corner),
                      child: ClipPath(
                        clipper: ConrerIndentedClipper(indent: const Size(36, 36), corner: corner),
                        child: Image.asset(vendor.image, width: double.infinity, height: double.infinity, fit: BoxFit.cover),
                      ),
                    ),
                    Align(alignment: corner.alignment, child: const DecoratedFavoriteWidget(size: 24, padding: 4, isDarkContainer: false)),
                    Align(
                      alignment: corner.alignment == Alignment.topLeft ? Alignment.topRight : Alignment.topLeft,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Co.secondary,
                          borderRadius: BorderRadius.only(
                            topLeft: corner.alignment == Alignment.topLeft ? Radius.zero : const Radius.circular(12),
                            topRight: corner.alignment == Alignment.topLeft ? const Radius.circular(12) : Radius.zero,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 8),
                          child: Text(L10n.tr().bestOffer, style: TStyle.primaryBold(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(vendor.name, style: TStyle.primaryBold(14), maxLines: 1),
          ],
        ),
      ),
    );
  }
}
