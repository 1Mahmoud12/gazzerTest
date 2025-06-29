import 'package:flutter/material.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/widgets/form_related_widgets.dart/main_text_field.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/title_with_more.dart';
import 'package:gazzer/features/resturants/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';

part 'components/top_rated_component.dart';
part 'widgets/grocery_add_widget.dart';
part 'widgets/grocery_header.dart';

class GroceryScreen extends StatefulWidget {
  const GroceryScreen({super.key});

  @override
  State<GroceryScreen> createState() => _GroceryScreenState();
}

class _GroceryScreenState extends State<GroceryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(showCart: false),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _GroceryHeader(),
          const VerticalSpacing(24),
          SubCategoriesWidget(addsIndeces: {}, onSubCategorySelected: (index) {}, subCategories: Fakers.fakeSubCats),
          const VerticalSpacing(24),
          const _GroceryAddWidget(),
          const VerticalSpacing(24),
          const _TopRatedComponent(),
        ],
      ),
    );
  }
}
