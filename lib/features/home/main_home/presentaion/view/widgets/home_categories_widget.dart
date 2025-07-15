part of '../home_screen.dart';

class _HomeCategoriesComponent extends StatelessWidget {
  const _HomeCategoriesComponent({required this.items});
  final List<CategoryEntity> items;
  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            L10n.tr().categories,
            style: TStyle.primaryBold(16),
          ).withHotspot(order: 2, title: "", text: L10n.tr().chooseYourCategories),
          GridView.builder(
            padding: AppConst.defaultHrPadding,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 77,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              mainAxisExtent: 117,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: items[index]);
            },
          ),
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final CategoryEntity category;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        // clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: GradientBoxBorder(gradient: Grad().shadowGrad(false), width: 1.5),
          borderRadius: BorderRadius.circular(constraints.maxWidth),
          // shadows will enforce that the gradient has no opacity
          gradient: Grad().bglightLinear.copyWith(
            colors: [const Color(0xFFD0CADA), Co.bg],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
        ),
        height: constraints.minHeight,
        width: constraints.maxWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(constraints.maxWidth)),
          ),
          clipBehavior: Clip.hardEdge,
          onPressed: () {
            context.myPush(
              BlocProvider(
                create: (context) => di<RestaurantsMenuCubit>(),
                child: const RestaurantsMenu(),
              ),
            );
          },
          child: Column(
            spacing: 4,
            children: [
              CircleGradientBorderedImage(image: category.image),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text(
                    category.name,
                    style: TStyle.blackSemi(12),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
