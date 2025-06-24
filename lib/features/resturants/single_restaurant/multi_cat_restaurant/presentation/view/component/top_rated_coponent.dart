part of '../multi_cat_restaurant_screen.dart';

class _TopRatedCoponent extends StatelessWidget {
  const _TopRatedCoponent({required this.subCats, required this.vendor});
  final List<SubcategoryModel> subCats;
  final VendorModel vendor;
  @override
  Widget build(BuildContext context) {
    int currentindex = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GradientText(text: "Top Rated", style: TStyle.blackBold(24)),
        ),
        Padding(
          padding: const EdgeInsetsGeometry.symmetric(horizontal: 8),
          child: Text("Explore The Best Meals", style: TStyle.blackBold(14)),
        ),
        SizedBox(
          height: 420,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.topCenter,
            children: [
              CircularCarousalWidget(
                itemsCount: Fakers.fakeProds.length,
                maxItemWidth: 128,
                itemBuilder: (BuildContext context, int index) {
                  return _TopRatedCard(Fakers.fakeProds[index]);
                },
              ),
              Align(
                alignment: const Alignment(0, 0.7),
                child: Column(
                  spacing: 8,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Earn Your First 5 Orders For Free", style: TStyle.blackBold(16)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return SubCategoriesWidget(
                            subCategories: subCats,
                            onSubCategorySelected: (index) {
                              Navigator.of(context).push(
                                AppTransitions().slideTransition(
                                  RestaurantCategoryScreen(subCat: subCats[index], vendor: vendor),
                                  start: const Offset(0, 1),
                                  duration: const Duration(milliseconds: 750),
                                  curve: Curves.linear,
                                ),
                              );
                            },
                            selectedId: currentindex,
                            addsIndeces: {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
