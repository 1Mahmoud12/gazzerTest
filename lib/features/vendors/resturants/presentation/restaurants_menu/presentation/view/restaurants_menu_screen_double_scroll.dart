// import 'package:flutter/material.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';import 'package:gazzer/core/presentation/utils/extensions.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gazzer/core/data/resources/fakers.dart';
// import 'package:gazzer/core/presentation/localization/l10n.dart';
// import 'package:gazzer/core/presentation/theme/app_theme.dart';
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/main_app_bar.dart';
// import 'package:gazzer/core/presentation/views/widgets/helper_widgets/spacing.dart';
// import 'package:gazzer/core/presentation/views/widgets/products/cart_floating_btn.dart';
// import 'package:gazzer/features/vendors/resturants/common/view/list_with_tabs_component.dart';
// import 'package:gazzer/features/vendors/resturants/common/view/vert_card/horz_scroll_vert_card_vendors_list_component.dart';
// import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_cubit.dart';
// import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/cubit/restaurants_menu_states.dart';
// import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_carousal.dart';
// import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/widgets/rest_cat_header_widget.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class RestaurantsMenuScreenDoubleScroll extends StatelessWidget {
//   const RestaurantsMenuScreenDoubleScroll({super.key});
//   static const route = '/restaurants-menu';
//   @override
//   Widget build(BuildContext context) {
//     final topPadding = MediaQuery.paddingOf(context).top;
//     return Scaffold(
//       floatingActionButton: const CartFloatingBtn(),
//       body: LayoutBuilder(
//         builder: (context, constraints) => BlocBuilder<RestaurantsMenuCubit, RestaurantsMenuStates>(
//           builder: (context, state) {
//             if (state is! RestaurantsCategoriesLoaded) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             final tabs = (state).categories.map((e) => (e.image, e.name)).toList();
//             return Skeletonizer(
//               enabled: false,
//               child: NestedScrollView(
//                 headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//                   return [
//                     SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         (context, index) => ListTile(
//                           title: Text('Parent Item $index'),
//                         ),
//                         childCount: 10, // Parent scroll view items
//                       ),
//                     ),
//                     SliverAppBar(
//                       pinned: true, // Sticky header
//                       title: Column(
//                         children: [
//                           const MainAppBar(showCart: false),
//                           const RestCatHeaderWidget(),
//                           VerticalSpacing(topPadding + 16),
//                           const RestCatCarousal(),
//                           const VerticalSpacing(kToolbarHeight),
//                           Padding(
//                             padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
//                             child: Text(L10n.tr().chooseYourFavoriteVendor, style: context.style16400.copyWith(fontWeight:TStyle.bold)),
//                           ),
//                         ],
//                       ),
//                       backgroundColor: Colors.blue,
//                     ),
//                   ];
//                 },
//                 body: SizedBox(
//                   child: ListWithTabsComponent(
//                     itemCount: tabs.length,
//                     maxHeight: constraints.maxHeight - topPadding - kToolbarHeight,
//                     tabs: tabs,
//                     listItemBuilder: (context, index) {
//                       final rest = Fakers.restaurants;
//                       final child = HorzScrollVertCardVendorsListComponent(
//                         items: rest,
//                         title: "Section ${index + 1}",
//                         onViewAllPressed: null,
//                       );
//                       if (index == tabs.length - 1) {
//                         return ConstrainedBox(
//                           constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),
//                           child: child,
//                         );
//                       }
//                       return child;
//                     },
//                   ),
//                 ),
//               ),

//               // ScrollableTabedList(
//               //   preHerader: Column(
//               //     children: [
//               //       const MainAppBar(showCart: false),
//               //       const RestCatHeaderWidget(),
//               //       VerticalSpacing(topPadding + 16),
//               //       const _RestCatCarousal(),
//               //       const VerticalSpacing(kToolbarHeight),
//               //       Padding(
//               //         padding: const EdgeInsetsGeometry.symmetric(vertical: 16),
//               //         child: Text(L10n.tr().chooseYourFavoriteVendor, style: context.style16400.copyWith(fontWeight:TStyle.bold)),
//               //       ),
//               //     ],
//               //   ),
//               //   tabs: tabs,
//               //   listItemBuilder: (context, index) {
//               //     final rest = Fakers.restaurants;
//               //     final child = HorzScrollVertCardVendorsListComponent(
//               //       items: rest,
//               //       title: "Section ${index + 1}",
//               //       onViewAllPressed: null,
//               //     );
//               //     if (index == tabs.length - 1) {
//               //       return ConstrainedBox(
//               //         constraints: BoxConstraints(minHeight: constraints.maxHeight - 40),
//               //         child: child,
//               //       );
//               //     }
//               //     return child;
//               //   },
//               // ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
