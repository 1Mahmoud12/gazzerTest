import 'package:flutter/widgets.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/features/resturants/restaurants_menu/data/subcategory_model.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/components/horz_scroll_horz_card_vendors_list_component.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/components/horz_scroll_vert_card_vendors_list_component.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/components/vert_scroll_cert_card_vendor_grid_component.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/components/vert_scroll_horz_card_vendors_list_component.dart';

class SubCategories {
  SubCategories._();
  static final _inst = SubCategories._();
  factory SubCategories() => _inst;

  int _index = 0;
  int get index {
    if (_index >= 4) _index = -1;
    return ++_index;
  }

  Widget getCatWidget(SubcategoryModel subCat) => [
    HorzScrollHorzCardVendorsListComponent(subcat: subCat),
    HorzScrollVertCardVendorsListComponent(subcat: subCat),
    VerticalVendorGridComponent(subCat: subCat),
    HorzScrollHorzCardVendorsListComponent(subcat: subCat, corner: Corner.topLeft),
    VertScrollHorzCardVendorsListComponent(subcat: subCat),
  ][index];
}
