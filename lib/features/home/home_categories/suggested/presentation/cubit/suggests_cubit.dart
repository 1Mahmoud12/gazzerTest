import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/home_categories/suggested/data/dtos/suggests_dto.dart';
import 'package:gazzer/features/home/home_categories/suggested/domain/suggests_repo.dart';
import 'package:gazzer/features/home/home_categories/suggested/presentation/cubit/suggests_states.dart';

class SuggestsCubit extends Cubit<SuggestsStates> {
  final SuggestsRepo _repo;
  int _currentPage = 1;
  final int _perPage = 10;
  PaginationInfo? _pagination;
  List<SuggestEntity> _allEntities = [];

  SuggestsCubit(this._repo) : super(SuggestsInitialState());

  Future<void> getSuggests({bool loadMore = false}) async {
    if (loadMore) {
      if (_pagination == null || !_pagination!.hasNext) return;
      _currentPage++;
      emit(SuggestsLoadingMoreState(
        SuggestsDtoData(entities: _allEntities),
        _pagination,
      ));
    } else {
      emit(SuggestsLoadingState());
      _currentPage = 1;
      _allEntities.clear();

      // Try to get cached data first
      final cached = await _repo.getCachedSuggests();
      final hasCachedData = cached != null && cached.entities.isNotEmpty;

      if (hasCachedData) {
        _allEntities = List.from(cached.entities);
        emit(SuggestsSuccessState(cached, isFromCache: true));
      }
    }

    // Fetch fresh data from API
    final res = await _repo.getSuggests(page: _currentPage, perPage: _perPage);
    switch (res) {
      case final Ok<SuggestsResponse> ok:
        if (loadMore) {
          _allEntities.addAll(ok.value.data?.entities ?? []);
        } else {
          _allEntities = List.from(ok.value.data?.entities ?? []);
        }
        _pagination = ok.value.pagination;
        emit(SuggestsSuccessState(
          SuggestsDtoData(entities: _allEntities),
          pagination: _pagination,
        ));
        break;
      case final Err err:
        if (!loadMore) {
          emit(SuggestsErrorState(err.error.message));
        }
        break;
    }
  }

  bool get hasMore => _pagination?.hasNext ?? false;

  @override
  void emit(SuggestsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
