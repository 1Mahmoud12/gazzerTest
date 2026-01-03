import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/resources/app_const.dart';
import 'package:gazzer/core/presentation/resources/resources.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/core/presentation/views/components/failure_component.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/helper_widgets.dart';
import 'package:gazzer/core/presentation/views/widgets/products/circle_gradient_image.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/all_categories_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/all_categories_states.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/vendors/resturants/presentation/restaurants_menu/presentation/view/restaurants_menu_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/pharmacy_menu/pharmacy_menu_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/store_menu_switcher.dart';
import 'package:go_router/go_router.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  static const route = '/all-categories';

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  final ScrollController _scrollController = ScrollController();
  AllCategoriesCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.8) {
      final cubit = _cubit;
      if (cubit != null) {
        final currentState = cubit.state;
        if (cubit.hasMore && currentState is! AllCategoriesLoadingMoreState) {
          cubit.getAllCategories(loadMore: true);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: L10n.tr().categories,
        titleStyle: TStyle.robotBlackTitle().copyWith(color: Co.purple),
      ),
      body: BlocProvider(
        create: (context) {
          _cubit = di<AllCategoriesCubit>()..getAllCategories();
          return _cubit!;
        },
        child: BlocBuilder<AllCategoriesCubit, AllCategoriesStates>(
          builder: (context, state) {
            if (state is AllCategoriesLoadingState) {
              return const Center(child: AdaptiveProgressIndicator());
            }
            if (state is AllCategoriesErrorState) {
              return FailureComponent(
                message: state.error,
                onRetry: () {
                  context.read<AllCategoriesCubit>().getAllCategories();
                },
              );
            }
            if (state is AllCategoriesSuccessState || state is AllCategoriesLoadingMoreState) {
              final categories = state is AllCategoriesSuccessState ? state.categories : (state as AllCategoriesLoadingMoreState).categories;
              final isLoadingMore = state is AllCategoriesLoadingMoreState;
              final pagination = state is AllCategoriesSuccessState ? state.pagination : (state as AllCategoriesLoadingMoreState).pagination;

              if (categories.isEmpty && !isLoadingMore) {
                return Center(child: Text(L10n.tr().noData, style: TStyle.mainwSemi(14)));
              }

              return CustomScrollView(
                controller: _scrollController,
                cacheExtent: 100,
                slivers: [
                  SliverPadding(
                    padding: AppConst.defaultPadding,
                    sliver: SliverToBoxAdapter(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        alignment: WrapAlignment.spaceBetween,
                        children: categories.map((category) {
                          return SizedBox(
                            width: ((MediaQuery.sizeOf(context).width) / 2) - 24,
                            child: _CategoryGridCard(category: category),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  if (isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: AdaptiveProgressIndicator()),
                      ),
                    ),
                  if (pagination != null && !pagination.hasNext && categories.isNotEmpty)
                    const SliverToBoxAdapter(
                      child: Padding(padding: EdgeInsets.all(16.0), child: SizedBox.shrink()),
                    ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _CategoryGridCard extends StatelessWidget {
  const _CategoryGridCard({required this.category});

  final MainCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Co.purple100),
        borderRadius: BorderRadius.circular(24),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.all(16),
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        clipBehavior: Clip.hardEdge,
        onPressed: () {
          if (category.type == VendorType.restaurant) {
            context.push(RestaurantsMenuScreen.route);
          } else if (category.type == VendorType.grocery) {
            StoreMenuSwitcherRoute(id: category.id).push(context);
          } else if (category.type == VendorType.pharmacy) {
            PharmacyMenuRoute(id: category.id).push(context);
          } else {
            Alerts.showToast(L10n.tr().notSetYet);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 80, height: 80, child: CircleGradientBorderedImage(image: category.image)),
            const VerticalSpacing(8),
            Text(category.name, style: TStyle.robotBlackMedium(), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
