import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class SearchCategoriesComponent extends StatefulWidget {
  const SearchCategoriesComponent({super.key, required this.categories, required this.onTap, this.initIndex});
  final List<MainCategoryEntity> categories;
  final Function(int? id) onTap;
  final int? initIndex;
  @override
  State<SearchCategoriesComponent> createState() => _SearchCategoriesComponentState();
}

class _SearchCategoriesComponentState extends State<SearchCategoriesComponent> with SingleTickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    // Add 1 for "All" tab
    tabController = TabController(length: widget.categories.length + 1, vsync: this);
    // Set initial index to 0 (All) if initIndex is null or -1
    if (widget.initIndex == null || widget.initIndex == -1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (tabController.index != 0) {
          tabController.animateTo(0);
        }
      });
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant SearchCategoriesComponent oldWidget) {
    // Update controller length if categories changed
    if (widget.categories.length != oldWidget.categories.length) {
      tabController.dispose();
      tabController = TabController(length: widget.categories.length + 1, vsync: this);
    }

    // Handle initIndex: -1 means "All" (index 0), null means "All", otherwise add 1 for "All" tab
    int targetIndex;
    if (widget.initIndex == null || widget.initIndex == -1) {
      targetIndex = 0; // "All" tab
    } else {
      targetIndex = widget.initIndex! + 1; // Add 1 because "All" is at index 0
    }

    if (tabController.index != targetIndex) {
      tabController.animateTo(targetIndex);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      physics: const ClampingScrollPhysics(),
      controller: tabController,
      isScrollable: true,
      dividerColor: Colors.transparent,
      dividerHeight: 0.5,
      unselectedLabelStyle: TStyle.robotBlackMedium().copyWith(fontWeight: FontWeight.w400),
      labelStyle: TStyle.robotBlackMedium().copyWith(color: Co.purple, fontWeight: FontWeight.w400),
      padding: EdgeInsets.zero,
      tabAlignment: TabAlignment.start,
      indicatorWeight: 1,
      onTap: (value) {
        if (value == 0) {
          // "All" tab selected - pass null for categoryId
          widget.onTap(null);
        } else {
          // Category tab selected - subtract 1 because "All" is at index 0
          widget.onTap(widget.categories[value - 1].id);
        }
      },
      tabs: [
        // "All" tab at index 0
        Tab(child: Text(L10n.tr().walletFilterAll)),
        // Category tabs
        ...List.generate(widget.categories.length, (index) => Tab(child: Text(widget.categories[index].name))),
      ],
    );
  }
}
