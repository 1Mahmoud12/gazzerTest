import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/data/search_response.dart';
import 'package:gazzer/features/search/domain/search_repo.dart';
import 'package:gazzer/features/search/presentaion/view/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _repo;
  SearchCubit(this._repo) : super(SearchInitial());
  int currentPage = 1;
  int lastPage = 1;

  Future<void> performSearch(SearchQuery query) async {
    emit(SearchLoading());
    final result = await _repo.search(query);
    switch (result) {
      case Ok<SearchResponse> ok:
        currentPage = ok.value.currentPage;
        lastPage = ok.value.lastPage;
        emit(SearchSuccess(vendors: ok.value.vendors));
        break;
      case Err<SearchResponse> err:
        emit(SearchError(message: err.error.message));
        break;
    }
  }

  Future<void> loadMoreResults(SearchQuery query) async {
    if (query.currentPage >= lastPage) return; // No more pages to load

    emit(LoadMoreResultsLoading());
    final result = await _repo.search(query.copyWith(currentPage: currentPage + 1));
    switch (result) {
      case Ok<SearchResponse> ok:
        currentPage = ok.value.currentPage;
        lastPage = ok.value.lastPage;
        emit(LoadMoreResultsSuccess(vendors: ok.value.vendors));
        break;
      case Err<SearchResponse> err:
        emit(LoadMoreResultsError(message: err.error.message));
        break;
    }
  }

  SearchQuery _query = const SearchQuery();
  SearchQuery get query => _query;

  void updateFilter(SearchQuery filter) {
    _query = filter;
    emit(SearchFilterState(query: _query));
  }
}
