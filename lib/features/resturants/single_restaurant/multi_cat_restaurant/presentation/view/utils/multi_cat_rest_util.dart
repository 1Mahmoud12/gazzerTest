part of '../multi_cat_restaurant_screen.dart';

class MultiCatRestUTils {
  int _index = -1;
  int get index {
    _index++;
    if (_index > 4) _index = 0; // 3 is items list legnth
    return _index;
  }

  Widget getCatWidget(SubcategoryModel subCat) => [
    CategoryOptionComponent(
      subCat: subCat,
      itemCount: Fakers.fakeProds.length,
      builder: (_, index) => _HorProductCard(prod: Fakers.fakeProds[index]),
    ),
    CategoryOptionComponent(
      subCat: subCat,
      itemCount: Fakers.fakeProds.length,
      height: 190,
      builder: (_, index) => _VertProductCard(prod: Fakers.fakeProds[index]),
    ),
    CategoryOptionComponent(
      subCat: subCat,
      itemCount: Fakers.fakeProds.length,
      separator: 16,
      height: 140,
      builder: (_, index) => _MiniProductCard(prod: Fakers.fakeProds[index]),
    ),
    CategoryOptionComponent(
      subCat: subCat,
      itemCount: Fakers.fakeProds.length,
      separator: 16,
      height: 140,
      builder: (_, index) => _MiniBorderedProductCard(prod: Fakers.fakeProds[index]),
    ),
    Padding(
      padding: AppConst.defaultHrPadding,
      child: Column(
        spacing: 12,
        children: [
          TitleWithMore(title: subCat.name, onPressed: () {}),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.1, crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 8),

            itemBuilder: (_, index) {
              return SingleGridProduct(isTop: index.isEven, prod: Fakers.fakeProds[index]);
            },
          ),
        ],
      ),
    ),
  ][index];
}
