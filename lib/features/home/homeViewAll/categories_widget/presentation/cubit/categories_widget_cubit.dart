import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/domain/categories_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/categories_widget_states.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class CategoriesWidgetCubit extends Cubit<CategoriesWidgetStates> {
  final CategoriesWidgetRepo _repo;

  CategoriesWidgetCubit(this._repo) : super(CategoriesWidgetInitialState());

  Future<void> getCategories() async {
    emit(CategoriesWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedCategories();
    final hasCachedData = cached != null && cached.isNotEmpty;

    if (hasCachedData) {
      emit(CategoriesWidgetSuccessState(cached, isFromCache: true));
    }

    // Fetch data from API
    final res = await _repo.getCategories();
    switch (res) {
      case final Ok<List<MainCategoryEntity>> ok:
        emit(CategoriesWidgetSuccessState(ok.value));
        break;
      case final Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(CategoriesWidgetErrorState(err.error.message));
        }
        break;
    }
  }

  @override
  void emit(CategoriesWidgetStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
