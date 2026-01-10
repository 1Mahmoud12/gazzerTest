import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/domain/all_categories_repo.dart';
import 'package:gazzer/features/home/homeViewAll/categories_widget/presentation/cubit/all_categories_states.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';

class AllCategoriesCubit extends Cubit<AllCategoriesStates> {
  final AllCategoriesRepo _repo;
  int _currentPage = 1;
  final int _perPage = 20;
  PaginationInfo? _pagination;
  List<MainCategoryEntity> _allCategories = [];

  AllCategoriesCubit(this._repo) : super(AllCategoriesInitialState());

  Future<void> getAllCategories({bool loadMore = false}) async {
    if (loadMore) {
      if (_pagination == null || !_pagination!.hasNext) return;
      _currentPage++;
      emit(AllCategoriesLoadingMoreState(_allCategories, _pagination));
    } else {
      emit(AllCategoriesLoadingState());
      _currentPage = 1;
      _allCategories.clear();
    }

    // Fetch data from API
    final res = await _repo.getAllCategories(
      page: _currentPage,
      perPage: _perPage,
    );
    switch (res) {
      case final Ok<AllCategoriesResponse> ok:
        if (loadMore) {
          _allCategories.addAll(ok.value.categories);
        } else {
          _allCategories = List.from(ok.value.categories);
        }
        _pagination = ok.value.pagination;
        emit(
          AllCategoriesSuccessState(_allCategories, pagination: _pagination),
        );
        break;
      case final Err err:
        if (!loadMore) {
          emit(AllCategoriesErrorState(err.error.message));
        }
        break;
    }
  }

  bool get hasMore => _pagination?.hasNext ?? false;

  @override
  void emit(AllCategoriesStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
