import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/data/dtos/categories_widget_dto.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/domain/categories_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/categories_widget_states.dart';

class CategoriesWidgetCubit extends Cubit<CategoriesWidgetStates> {
  final CategoriesWidgetRepo _repo;

  CategoriesWidgetCubit(this._repo) : super(CategoriesWidgetInitialState());

  Future<void> getCategories() async {
    emit(CategoriesWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedCategories();
    final hasCachedData = cached != null && cached.entities.isNotEmpty;

    if (hasCachedData) {
      emit(
        CategoriesWidgetSuccessState(
          cached.entities,
          cached.banner,
          isFromCache: true,
        ),
      );
    }

    // Fetch data from API
    final res = await _repo.getCategories();
    switch (res) {
      case final Ok<CategoriesWidgetData> ok:
        emit(CategoriesWidgetSuccessState(ok.value.entities, ok.value.banner));
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
