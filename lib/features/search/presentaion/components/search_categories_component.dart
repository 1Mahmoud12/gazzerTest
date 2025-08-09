import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class SearchCategoriesComponent extends StatefulWidget {
  const SearchCategoriesComponent({super.key, required this.categories, required this.onTap});
  final List<MainCategoryEntity> categories;
  final Function(int id) onTap;
  @override
  State<SearchCategoriesComponent> createState() => _SearchCategoriesComponentState();
}

class _SearchCategoriesComponentState extends State<SearchCategoriesComponent> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: widget.categories.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      physics: const ClampingScrollPhysics(),
      controller: tabController,
      isScrollable: true,
      dividerColor: Colors.transparent,
      dividerHeight: 0.5,
      unselectedLabelStyle: TStyle.greyBold(14).copyWith(color: Colors.grey),
      labelStyle: TStyle.primaryBold(14),
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      onTap: (value) {
        widget.onTap(widget.categories[value].id);
      },
      // labelPadding: EdgeInsets.zero,
      tabs: List.generate(
        widget.categories.length,
        (index) => Tab(
          child: Row(
            spacing: 6,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.refresh, color: Co.greyText, size: 24),
              Text(widget.categories[index].name),
            ],
          ),
        ),
      ),
    );
  }
}
