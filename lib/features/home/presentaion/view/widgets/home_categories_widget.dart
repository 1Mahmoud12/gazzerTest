part of '../home_screen.dart';

class _HomeCategoriesWidget extends StatelessWidget {
  const _HomeCategoriesWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Categories", style: TStyle.primaryBold(16)),
            TextButton(
              onPressed: () {},
              child: const Text("View All", style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
        GridView.builder(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 90,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 0.58,
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
          // color: Co.bg,
          boxShadow: [const BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 4))],
        ),
        height: constraints.minHeight,
        width: constraints.maxWidth,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Co.bg,
            padding: EdgeInsets.zero,
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(constraints.maxWidth)),
          ),
          onPressed: () {
            context.myPush(RestaurantsCatScreen(id: category.id));
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
