part of '../home_screen.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  const _HomeCategoriesWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Text(
          "Categories",
          style: TStyle.primaryBold(16),
        ).withHotspot(order: 2, title: "", text: L10n.tr().chooseYourCategories),
        GridView.builder(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 77,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            mainAxisExtent: 117,
          ),
          itemCount: Fakers.fakeCats.length,
          itemBuilder: (context, index) {
            return CategoryItem(category: Fakers.fakeCats[index]);
          },
        ),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        // clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: GradientBoxBorder(gradient: Grad.shadowGrad(false), width: 1.5),
          borderRadius: BorderRadius.circular(constraints.maxWidth),
          // shadows will enforce that the gradient has no opacity
          gradient: Grad.bglightLinear.copyWith(
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
          onPressed: () {
            context.myPush(RestaurantsMenu(id: category.id));
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
