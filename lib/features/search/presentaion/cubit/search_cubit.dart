import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/cancel_token.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/data/search_response.dart';
import 'package:gazzer/features/search/domain/search_repo.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';
import 'package:gazzer/features/search/presentaion/cubit/search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepo _repo;
  SearchCubit(this._repo) : super(SearchInitial());
  int currentPage = 1;
  int lastPage = 1;

  final _vendors = <SearchVendorEntity>[];
  final controller = TextEditingController();
  int? defaultCatId;
  // SearchQuery _query = const SearchQuery();
  // SearchQuery get query => _query;

  var token = CancelToken();
  void _terminatePrevCalss() {
    token.cancel();
    token = token.regenerate();
  }

  Future<void> performSearch(SearchQuery query) async {
    final newQuery = query.copyWith(searchWord: controller.text, currentPage: 1, categoryId: query.categoryId ?? defaultCatId);
    if (newQuery.searchWord.trim().length < 3) {
      emit(SearchSuccess(vendors: [], query: newQuery));
      return;
    }
    _terminatePrevCalss();
    currentPage = 1;
    emit(SearchLoading(query: newQuery));
    final result = await _repo.search(newQuery, token);
    switch (result) {
      case final Ok<SearchResponse> ok:
        currentPage = ok.value.currentPage;
        lastPage = ok.value.lastPage;
        _vendors.clear();
        _vendors.addAll(ok.value.vendors);
        emit(SearchSuccess(vendors: _vendors, query: newQuery));
        break;
      case final Err<SearchResponse> err:
        if (err.error.e == ErrorType.cancel) {
          // Request was cancelled, do nothing
          return;
        }
        emit(SearchError(message: err.error.message, query: newQuery));
        break;
    }
  }

  Future<void> loadMoreResults() async {
    if (state.query.currentPage >= lastPage) return; // No more pages to load
    _terminatePrevCalss();
    final newQueryy = state.query.copyWith(currentPage: currentPage + 1);
    emit(LoadMoreResultsLoading(query: state.query, vendors: _vendors));
    final result = await _repo.search(newQueryy, token);
    switch (result) {
      case final Ok<SearchResponse> ok:
        currentPage = ok.value.currentPage;
        lastPage = ok.value.lastPage;
        _vendors.addAll(ok.value.vendors);
        emit(LoadMoreResultsSuccess(vendors: _vendors, query: newQueryy));
        break;
      case final Err<SearchResponse> err:
        emit(LoadMoreResultsError(message: err.error.message, query: newQueryy));
        break;
    }
  }

  Future<void> loadCategories() async {
    emit(LoadCategoriesLoading());
    final result = await _repo.getCategories();
    switch (result) {
      case final Ok<List<MainCategoryEntity>> ok:
        if (ok.value.isNotEmpty) defaultCatId = ok.value.first.id;
        emit(LoadCategoriesSuccess(categories: ok.value));
        break;
      case final Err<List<MainCategoryEntity>> err:
        emit(LoadCategoriesError(message: err.error.message));
        break;
    }
  }

  @override
  Future<void> close() {
    controller.dispose();
    return super.close();
  }
}
