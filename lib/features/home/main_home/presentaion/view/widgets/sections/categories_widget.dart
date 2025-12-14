import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/adaptive_progress_indicator.dart';
import 'package:gazzer/features/home/home_categories/categories_widget/presentation/cubit/categories_widget_cubit.dart';
import 'package:gazzer/features/home/home_categories/categories_widget/presentation/cubit/categories_widget_states.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/home_screen.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesWidgetCubit, CategoriesWidgetStates>(
      builder: (context, categoriesState) {
        if (categoriesState is CategoriesWidgetSuccessState) {
          return HomeCategoriesComponent(items: categoriesState.categories);
        } else if (categoriesState is CategoriesWidgetLoadingState) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Center(child: AdaptiveProgressIndicator()),
            ),
          );
        } else if (categoriesState is CategoriesWidgetErrorState) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }
        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
