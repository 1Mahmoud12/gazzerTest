import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/pkgs/single_list_tab_scrollable/item_positions_listener.dart';
import 'package:gazzer/core/presentation/pkgs/single_list_tab_scrollable/scroll_offset_listener.dart';
import 'package:gazzer/core/presentation/pkgs/single_list_tab_scrollable/scrollable_positioned_list.dart';
import 'package:gazzer/core/presentation/pkgs/single_list_tab_scrollable/scrolls_to_top.dart';

typedef IndexedActiveStatusWidgetBuilder = Widget Function(BuildContext context, int index, bool active);
typedef IndexedVoidCallback = void Function(int index);

typedef HeaderContainerBuilder = Widget Function(BuildContext context, Widget child);
typedef BodyContainerBuilder = Widget Function(BuildContext context, Widget child);

class ScrollableListTabScroller extends StatefulWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedActiveStatusWidgetBuilder tabBuilder;
  final HeaderContainerBuilder? headerContainerBuilder;
  final BodyContainerBuilder? bodyContainerBuilder;
  final ItemScrollController? itemScrollController;
  final ItemPositionsListener? itemPositionsListener;
  final void Function(int tabIndex)? tabChanged;
  final double earlyChangePositionOffset;
  final Duration animationDuration;
  final bool hasBody;
  const ScrollableListTabScroller({
    super.key,
    required this.hasBody,
    required this.itemCount,
    required this.itemBuilder,
    required this.tabBuilder,
    this.headerContainerBuilder,
    @Deprecated("This code is unused and will be removed in the next release.")
    Widget Function(BuildContext context, Widget child)? headerWidgetBuilder,
    this.bodyContainerBuilder,
    this.itemScrollController,
    this.itemPositionsListener,
    this.tabChanged,
    this.earlyChangePositionOffset = 0,
    this.animationDuration = const Duration(milliseconds: 300),
    this.shrinkWrap = false,
    this.initialScrollIndex = 0,
    this.initialAlignment = 0,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.physics,
    this.semanticChildCount,
    this.padding,
    this.addSemanticIndexes = true,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.minCacheExtent,
    this.scrollOffsetController,
    this.scrollOffsetListener,
  });

  final ScrollOffsetController? scrollOffsetController;

  final ScrollOffsetListener? scrollOffsetListener;

  final int initialScrollIndex;

  final double initialAlignment;

  final Axis scrollDirection;

  final bool reverse;

  final bool shrinkWrap;

  final ScrollPhysics? physics;

  final int? semanticChildCount;

  final EdgeInsets? padding;

  final bool addSemanticIndexes;

  final bool addAutomaticKeepAlives;

  final bool addRepaintBoundaries;

  final double? minCacheExtent;

  @override
  ScrollableListTabScrollerState createState() => ScrollableListTabScrollerState();
}

class ScrollableListTabScrollerState extends State<ScrollableListTabScroller> {
  late final ItemScrollController itemScrollController;
  late final ItemPositionsListener itemPositionsListener;

  late final ValueNotifier<int> _selectedTabIndex;
  Timer? _debounce;
  Size _currentPositionedListSize = Size.zero;

  @override
  void initState() {
    super.initState();
    // try to use user controllers or create them
    itemScrollController = widget.itemScrollController ?? ItemScrollController();
    itemPositionsListener = widget.itemPositionsListener ?? ItemPositionsListener.create();

    itemPositionsListener.itemPositions.addListener(_itemPositionListener);
    _selectedTabIndex = ValueNotifier(widget.initialScrollIndex);
    _selectedTabIndex.addListener(onSelectedTabChange);
    // if (!widget.hasBody) {
    //   Future.delayed(Duration.zero, () => _selectedTabIndex.value = widget.initialScrollIndex);
    // }
  }

  void onSelectedTabChange() {
    final selectedTabIndex = _selectedTabIndex.value;
    final debounce = _debounce;

    if (debounce != null && debounce.isActive) {
      debounce.cancel();
    }

    _debounce = Timer(widget.animationDuration, () {
      widget.tabChanged?.call(selectedTabIndex);
    });
  }

  void _triggerScrollInPositionedListIfNeeded(int index) {
    if (getDisplayedPositionFromList() != index &&
        // Prevent operation when length == 0 (Component was rendered outside screen)
        itemPositionsListener.itemPositions.value.isNotEmpty) {
      // disableItemPositionListener = true;
      if (itemScrollController.isAttached) {
        //changed by me //
        itemScrollController.jumpTo(
          index: index,
          // duration: widget.animationDuration,
        );
      }
    }
  }

  void setCurrentActiveIfDifferent(int currentActive) {
    if (_selectedTabIndex.value != currentActive) _selectedTabIndex.value = currentActive;
  }

  void _itemPositionListener() {
    // Prevent operation when length == 0 (Component was rendered outside screen)
    if (itemPositionsListener.itemPositions.value.isEmpty) {
      return;
    }
    final displayedIdx = getDisplayedPositionFromList();
    if (displayedIdx != null) {
      setCurrentActiveIfDifferent(displayedIdx);
    }
  }

  int? getDisplayedPositionFromList() {
    final value = itemPositionsListener.itemPositions.value;
    if (value.isEmpty) {
      return null;
    }
    final orderedListByPositionIndex = value.toList()..sort((a, b) => a.index.compareTo(b.index));

    final renderedMostTopItem = orderedListByPositionIndex.first;
    if (renderedMostTopItem.getBottomOffset(_currentPositionedListSize) < widget.earlyChangePositionOffset) {
      if (orderedListByPositionIndex.length > 1) {
        return orderedListByPositionIndex[1].index;
      }
    }
    return renderedMostTopItem.index;
  }

  Widget buildCustomHeaderContainerOrDefault({required BuildContext context, required Widget child}) {
    return widget.headerContainerBuilder?.call(context, child) ??
        SizedBox(
          height: 30,
          child: child,
        );
  }

  Widget buildCustomBodyContainerOrDefault({required BuildContext context, required Widget child}) {
    return widget.bodyContainerBuilder?.call(context, child) ??
        Expanded(
          child: child,
        );
  }

  Future<void> _onScrollsToTop(ScrollsToTopEvent event) async {
    itemScrollController.scrollTo(index: 0, duration: event.duration, curve: event.curve);
  }

  @override
  Widget build(BuildContext context) {
    return !widget.hasBody
        ? buildCustomHeaderContainerOrDefault(
            context: context,
            child: DefaultHeaderWidget(
              key: Key(widget.itemCount.toString()),
              itemCount: widget.itemCount,
              onTapTab: (i) => widget.hasBody ? _triggerScrollInPositionedListIfNeeded(i) : setCurrentActiveIfDifferent(i),
              selectedTabIndex: _selectedTabIndex,
              tabBuilder: widget.tabBuilder,
            ),
          )
        : Column(
            children: [
              buildCustomHeaderContainerOrDefault(
                context: context,
                child: DefaultHeaderWidget(
                  key: Key(widget.itemCount.toString()),
                  itemCount: widget.itemCount,
                  onTapTab: (i) => _triggerScrollInPositionedListIfNeeded(i),
                  selectedTabIndex: _selectedTabIndex,
                  tabBuilder: widget.tabBuilder,
                ),
              ),
              buildCustomBodyContainerOrDefault(
                context: context,
                child: Builder(builder: (context) {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    final size = context.size;
                    if (size != null) {
                      _currentPositionedListSize = size;
                    }
                  });
                  return ScrollsToTop(
                    onScrollsToTop: _onScrollsToTop,
                    child: ScrollablePositionedList.builder(
                      itemBuilder: (a, b) {
                        return widget.itemBuilder(a, b);
                      },
                      itemCount: widget.itemCount,
                      itemScrollController: itemScrollController,
                      itemPositionsListener: itemPositionsListener,
                      shrinkWrap: widget.shrinkWrap,
                      initialScrollIndex: widget.initialScrollIndex,
                      initialAlignment: widget.initialAlignment,
                      scrollDirection: widget.scrollDirection,
                      reverse: widget.reverse,
                      physics: widget.physics,
                      semanticChildCount: widget.semanticChildCount,
                      padding: widget.padding,
                      addSemanticIndexes: widget.addSemanticIndexes,
                      addAutomaticKeepAlives: widget.addAutomaticKeepAlives,
                      addRepaintBoundaries: widget.addRepaintBoundaries,
                      minCacheExtent: widget.minCacheExtent,
                      scrollOffsetController: widget.scrollOffsetController,
                      scrollOffsetListener: widget.scrollOffsetListener,
                    ),
                  );
                }),
              )
            ],
          );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    itemPositionsListener.itemPositions.removeListener(_itemPositionListener);
    super.dispose();
  }
}

class DefaultHeaderWidget extends StatefulWidget {
  final ValueNotifier<int> selectedTabIndex;
  final IndexedActiveStatusWidgetBuilder tabBuilder;
  final IndexedVoidCallback onTapTab;
  final int itemCount;

  const DefaultHeaderWidget({
    super.key,
    required this.selectedTabIndex,
    required this.tabBuilder,
    required this.onTapTab,
    required this.itemCount,
  });

  @override
  State<DefaultHeaderWidget> createState() => _DefaultHeaderWidgetState();
}

class _DefaultHeaderWidgetState extends State<DefaultHeaderWidget> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: widget.selectedTabIndex.value,
      length: widget.itemCount,
      vsync: this,
    );
    _tabController.addListener(tabChangeListener);
    widget.selectedTabIndex.addListener(externalTabChangeListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    widget.selectedTabIndex.removeListener(externalTabChangeListener);
    super.dispose();
  }

  void tabChangeListener() {
    widget.onTapTab(_tabController.index);
  }

  void externalTabChangeListener() {
    _tabController.index = widget.selectedTabIndex.value;
  }

  void _onTapTab(_) {
    _tabController.index = widget.selectedTabIndex.value;
  }

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = DefaultTextStyle.of(context);
    final tabList = List.generate(
      widget.itemCount,
      (i) => ValueListenableBuilder(
        valueListenable: widget.selectedTabIndex,
        builder: (context, selectedIndex, child) => widget.tabBuilder(context, i, i == selectedIndex),
      ),
    );
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        //Changed by me //
        dividerColor: Colors.transparent,
        tabAlignment: TabAlignment.start,
        indicatorColor: Colors.transparent,
        unselectedLabelColor: Colors.transparent,
        padding: const EdgeInsets.all(0),
        //Changed by me //
        onTap: _onTapTab,
        indicator: const BoxDecoration(),
        indicatorWeight: 0,
        labelPadding: EdgeInsets.zero,
        automaticIndicatorColorAdjustment: false,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        labelColor: defaultTextStyle.style.color,
        isScrollable: true,
        controller: _tabController,
        tabs: tabList,
      ),
    );
  }
}

// Utils

extension _ItemPositionUtilsExtension on ItemPosition {
  double getBottomOffset(Size size) {
    return itemTrailingEdge * size.height;
  }
}
