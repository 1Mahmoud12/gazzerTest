part of '../home_screen.dart';

class HomeCategoriesComponent extends StatelessWidget {
  const HomeCategoriesComponent({super.key, required this.items, this.banner});

  final List<CategoryEntityDto> items;
  final BannerDTO? banner;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SliverToBoxAdapter(child: SizedBox.shrink());
    return SliverList(
      delegate: SliverChildListDelegate([
        // Banner above the section
        if (banner != null) ...[
          Padding(
            padding: AppConst.defaultHrPadding,
            child: MainBannerWidget(banner: banner!.toEntity()),
          ),
          const VerticalSpacing(24),
        ],
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TitleWithMore(
            title: L10n.tr().categories,
            titleStyle: TStyle.robotBlackSubTitle().copyWith(color: Co.purple),
            onPressed: () {
              context.push(AllCategoriesScreen.route);
            },
          ),
        ),
        const VerticalSpacing(12),
        SingleChildScrollView(
          padding: AppConst.defaultHrPadding,
          scrollDirection: Axis.horizontal,
          child: Row(children: List.generate(items.length, (index) => CategoryCard(category: items[index]))),
        ),

        const VerticalSpacing(24),
      ]),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryEntityDto category;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Co.purple100),
        borderRadius: BorderRadius.circular(24),
        // shadows will enforce that the gradient has no opacity
        // gradient: Grad().bglightLinear.copyWith(colors: [const Color(0xFFD0CADA), Co.bg], begin: Alignment.centerLeft, end: Alignment.centerRight),
        //boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
      ),

      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
          elevation: 0,
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(constraints.maxWidth)),
        ),
        clipBehavior: Clip.hardEdge,
        onPressed: () {
          if (category.type.toLowerCase() == VendorType.restaurant.name) {
            context.push(RestaurantsMenuScreen.route);
          } else if (category.type.toLowerCase() == VendorType.grocery.name) {
            StoreMenuSwitcherRoute(id: category.id).push(context);
          } else if (category.type.toLowerCase() == VendorType.pharmacy.name) {
            PharmacyMenuRoute(id: category.id).push(context);
          } else {
            //StoreMenuSwitcherRoute(id: category.id).push(context);

            log('Unknown category type: ${category.type}');
          }
        },
        child: Row(
          spacing: 8,
          children: [
            SizedBox(width: 60, height: 60, child: CircleGradientBorderedImage(image: category.image)),
            Text(category.name, style: TStyle.robotBlackMedium(), textAlign: TextAlign.center, overflow: TextOverflow.fade),
            const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
