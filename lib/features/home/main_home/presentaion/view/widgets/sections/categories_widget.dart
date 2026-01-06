import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/categories_widget_cubit.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/categories_widget_states.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesWidgetCubit, CategoriesWidgetStates>(
      buildWhen: (previous, current) {
        // Only rebuild if state type actually changed or data changed
        if (previous.runtimeType != current.runtimeType) return true;
        if (previous is CategoriesWidgetSuccessState && current is CategoriesWidgetSuccessState) {
          return previous.categories != current.categories || previous.banner != current.banner;
        }
        return false;
      },
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesWidgetSuccessState) {
          return HomeCategoriesComponent(items: categoriesState.categories, banner: categoriesState.banner);
        }
        /* else if (categoriesState is CategoriesWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (categoriesState is CategoriesWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }*/
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
