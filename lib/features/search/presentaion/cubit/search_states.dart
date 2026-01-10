import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/cubits/base_error_state.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';

sealed class SearchState {
  final SearchQuery query;
  final List<SearchVendorEntity> vendors;

  const SearchState({this.query = const SearchQuery(), this.vendors = const []});
}

class SearchInitial extends SearchState {}

sealed class SearchResultsStates extends SearchState {
  const SearchResultsStates({super.vendors = const [], required super.query});
}

///
class SearchLoading extends SearchResultsStates {
  SearchLoading({required super.query}) : super(vendors: Fakers.searchVendors);
}

class SearchSuccess extends SearchResultsStates {
  SearchSuccess({required super.vendors, required super.query});
}

class SearchError extends SearchResultsStates implements BaseErrorState {
  @override
  String message;
  SearchError({required this.message, required super.query});
}

///
sealed class LoadMoreResults extends SearchResultsStates {
  LoadMoreResults({super.vendors, required super.query});
}

class LoadMoreResultsLoading extends SearchResultsStates {
  LoadMoreResultsLoading({required super.query, required super.vendors});
}

class LoadMoreResultsSuccess extends SearchResultsStates {
  LoadMoreResultsSuccess({super.vendors, required super.query});
}

class LoadMoreResultsError extends SearchResultsStates implements BaseErrorState {
  @override
  String message;
  LoadMoreResultsError({required this.message, required super.query});
}

///
sealed class LoadCategoriesState extends SearchState {
  final List<MainCategoryEntity> categories;
  const LoadCategoriesState({this.categories = const []});
}

class LoadCategoriesLoading extends LoadCategoriesState {
  LoadCategoriesLoading() : super(categories: Fakers.fakeCats);
}

class LoadCategoriesSuccess extends LoadCategoriesState {
  LoadCategoriesSuccess({required super.categories});
}

///
class LoadCategoriesError extends LoadCategoriesState implements BaseErrorState {
  @override
  String message;
  LoadCategoriesError({required this.message});
}
