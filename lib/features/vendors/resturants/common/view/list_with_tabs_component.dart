// import 'package:flutter/material.dart';
// import 'package:gazzer/core/presentation/pkgs/scrolable_list_tab_scroller/scrollable_list_tab_scroller.dart';
// import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/sub_categories_widget.dart';

// class ListWithTabsComponent extends StatefulWidget {
//   const ListWithTabsComponent({
//     super.key,
//     required this.itemCount,
//     required this.tabs,
//     required this.listItemBuilder,
//     required this.maxHeight,
//   });
//   final int itemCount;
//   final List<(String image, String title)> tabs;
//   final Widget Function(BuildContext, int) listItemBuilder;
//   final double maxHeight;

//   @override
//   State<ListWithTabsComponent> createState() => _ListWithTabsComponentState();
// }

// class _ListWithTabsComponentState extends State<ListWithTabsComponent> {
//   final controller = ItemScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: BoxConstraints(maxHeight: widget.maxHeight),
//       child: ScrollableListTabScroller(
//         itemScrollController: controller,
//         animationDuration: Durations.medium3,
//         itemCount: widget.tabs.length,
//         shrinkWrap: true,
//         headerContainerBuilder: (context, child) => SizedBox(
//           height: 40,
//           child: child,
//         ),
//         tabBuilder: (context, index, active) {
//           final tab = widget.tabs[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 6),
//             child: SubCategoryItem(
//               image: tab.$1,
//               name: tab.$2,
//               isSelected: active,
//               ontap: () => controller.scrollTo(index: index, duration: Durations.short1),
//             ),
//           );
//         },
//         itemBuilder: (context, index) {
//           if (index == widget.itemCount - 1) {
//             return ConstrainedBox(
//               constraints: BoxConstraints(minHeight: widget.maxHeight - 40),
//               child: widget.listItemBuilder(context, index),
//             );
//           }
//           return widget.listItemBuilder(context, index);
//         },
//       ),
//     );
//   }
// }
