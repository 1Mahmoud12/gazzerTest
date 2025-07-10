part of "../restaurants_menu.dart";

class SubCatUtils {
  SubCatUtils._();
  static final _inst = SubCatUtils._();
  factory SubCatUtils() => _inst;

  int _index = 0;
  int get index {
    _index++;
    if (_index > 4) _index = 0;
    return _index;
  }

  Widget getCatWidget(CategoryOfPlateEntity subCat) => [
    HorzScrollHorzCardVendorsListComponent(subcat: subCat),
    HorzScrollVertCardVendorsListComponent(subcat: subCat),
    VerticalVendorGridComponent(subCat: subCat),
    HorzScrollHorzCardVendorsListComponent(subcat: subCat, corner: Corner.topLeft),
    VertScrollHorzCardVendorsListComponent(subcat: subCat),
  ][index];
}
