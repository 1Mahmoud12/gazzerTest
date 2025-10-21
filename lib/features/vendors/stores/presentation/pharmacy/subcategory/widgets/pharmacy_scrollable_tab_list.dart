import 'dart:math';

import 'package:easy_sticky_header/easy_sticky_header.dart';
import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';

class PharmacyScrollableTabedList extends StatefulWidget {
  const PharmacyScrollableTabedList({
    super.key,
    required this.itemsCount,
    required this.listItemBuilder,
    required this.preHerader,
    required this.tabBuilder,
    required this.tabContainerBuilder,
  });

  final int itemsCount;
  final Widget Function(BuildContext, int) listItemBuilder;
  final Widget Function(BuildContext, int, int) tabBuilder;
  final Widget Function(Widget child) tabContainerBuilder;

  final Widget preHerader;

  @override
  State<PharmacyScrollableTabedList> createState() => _PharmacyScrollableTabedListState();
}

class _PharmacyScrollableTabedListState extends State<PharmacyScrollableTabedList> with SingleTickerProviderStateMixin {
  late final StickyHeaderController _controller;
  late final TabController _tabController;
  final padding = ValueNotifier(0.0);
  final headerHeight = 40.0;
  double topPadding = 0;

  @override
  void initState() {
    super.initState();
    _controller = StickyHeaderController();
    _tabController = TabController(
      length: widget.itemsCount,
      vsync: this,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      topPadding = MediaQuery.paddingOf(context).top;
      _controller.addListener(_setHeaderPAdding);
    });
  }

  void _setHeaderPAdding() {
    final parentOffset = _controller.getStickyHeaderInfo(2)?.offset.dy;
    if (parentOffset != null) {
      final realoffset = parentOffset - headerHeight;
      if (realoffset < topPadding) {
        final paddingValue = topPadding - max(realoffset, 0);
        padding.value = paddingValue;
      } else {
        padding.value = 0;
      }
    } else {
      padding.value = 0;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_setHeaderPAdding);
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => StickyHeader(
        controller: _controller,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          reverse: false,
          physics: const AlwaysScrollableScrollPhysics(
            parent: ClampingScrollPhysics(),
          ),
          itemCount: widget.itemsCount + 2,
          itemBuilder: (context, index) {
            if (index < 1) {
              return widget.preHerader;
            } else if (index == 1) {
              /// Building parent header widget is not limited to using
              /// [ParentStickyContainerBuilder], [StickyContainerWidget] or
              /// [StickyContainerBuilder] can also be used.
              return ParentStickyContainerBuilder(
                index: index,
                onUpdate: (childStickyHeaderInfo) {
                  // if ((childStickyHeaderInfo?.index ?? 0) < 1) {
                  //   padding.value = 0.0;
                  // } else {
                  //   if (padding.value < topPadding) padding.value = topPadding;
                  // }
                  if (childStickyHeaderInfo == null) {
                    _tabController.animateTo(0);
                  } else if (childStickyHeaderInfo.index != _tabController.index + 2) {
                    _tabController.animateTo(childStickyHeaderInfo.index - 2);
                  }
                  return false;
                },
                builder: (context, childStickyHeaderInfo) {
                  return widget.tabContainerBuilder(
                    ValueListenableBuilder(
                      valueListenable: padding,
                      builder: (context, value, child) => Padding(
                        padding: EdgeInsets.only(top: max(value, 0)),
                        child: child,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: headerHeight,
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          controller: _tabController,
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 2.0,
                            ),
                          ),
                          tabs: List.generate(
                            widget.itemsCount,
                            (index) {
                              return ElevatedButton(
                                onPressed: () {
                                  // _tabController.animateTo(index);
                                  _controller.animateTo(index + 2, offset: 0.5);
                                },

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(borderRadius: AppConst.defaultInnerBorderRadius),
                                  padding: EdgeInsets.zero,
                                ),
                                child: widget.tabBuilder(context, index, _tabController.index),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              Widget child;
              if (index == widget.itemsCount + 1) {
                child = ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight - topPadding - 30),
                  child: widget.listItemBuilder(context, index - 2),
                );
              } else {
                child = widget.listItemBuilder(context, index - 2);
              }
              return StickyContainerWidget(index: index, parentIndex: 1, overlapParent: false, child: child);
            }
          },
        ),
      ),
    );
  }
}
