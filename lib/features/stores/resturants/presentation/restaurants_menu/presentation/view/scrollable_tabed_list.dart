import 'dart:math';

import 'package:easy_sticky_header/easy_sticky_header.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/features/stores/resturants/presentation/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';

class ScrollableTabedList extends StatefulWidget {
  const ScrollableTabedList({super.key, required this.tabs, required this.listItemBuilder, required this.preHerader});
  final List<(String image, String title)> tabs;
  final Widget Function(BuildContext, int) listItemBuilder;

  final Widget preHerader;
  @override
  State<ScrollableTabedList> createState() => _ScrollableTabedListState();
}

class _ScrollableTabedListState extends State<ScrollableTabedList> with SingleTickerProviderStateMixin {
  late final StickyHeaderController _controller;
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _controller = StickyHeaderController();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      controller: _controller,
      child: ListView.builder(
        shrinkWrap: true,
        reverse: false,
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        itemCount: widget.tabs.length + 2,
        itemBuilder: (context, index) {
          if (index > 1) {
            return SafeArea(bottom: false, child: _buildChildHeader1(index, 1));
          } else if (index == 1) {
            return _buildParentHeader1(index);
            // return _buildParentHeader2(index);
          } else {
            return widget.preHerader;
            // return _buildChildHeader2(index, parentIndex);
          }
          // return _buildItem(index);
        },
      ),
    );
  }

  /// Building parent header widget is not limited to using
  /// [ParentStickyContainerBuilder], [StickyContainerWidget] or
  /// [StickyContainerBuilder] can also be used.
  Widget _buildParentHeader1(int index) => ParentStickyContainerBuilder(
    index: index,
    onUpdate: (childStickyHeaderInfo) {
      print("childStickyHeaderInfo.index: ${childStickyHeaderInfo?.index}");
      print("_tabController.index: ${_tabController.index}");
      if (childStickyHeaderInfo != null && childStickyHeaderInfo.index != _tabController.index + 2) {
        _tabController.animateTo(childStickyHeaderInfo.index - 2);
      }
      // There is no need to rebuild the [TabBar] here, so return false.
      return false;
    },
    builder: (context, childStickyHeaderInfo) {
      return ColoredBox(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.only(top: max(MediaQuery.paddingOf(context).top, 24) + 8),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              tabs: List.generate(
                widget.tabs.length,
                (index) {
                  final tab = widget.tabs[index];
                  return SubCategoryItem(
                    image: tab.$1,
                    name: tab.$2,
                    isSelected: (childStickyHeaderInfo?.index == index),
                    ontap: () => _controller.animateTo(index + 2, offset: 0.5),
                  );
                },
              ),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: Colors.white,
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  Widget _buildChildHeader1(int index, int parentIndex) => StickyContainerWidget(
    index: index,
    parentIndex: parentIndex,
    // It is recommended to use the default value, which is more in line
    // with usage habits.
    overlapParent: false,
    child: widget.listItemBuilder(context, index - 2),
  );
}
