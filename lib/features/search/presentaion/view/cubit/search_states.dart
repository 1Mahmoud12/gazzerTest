import 'package:equatable/equatable.dart';
import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/presentation/cubits/base_error_state.dart';
import 'package:gazzer/features/search/data/search_query.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';

sealed class SearchState {
  const SearchState();
}

sealed class SearchResultsStates extends SearchState {
  final List<SearchVendorEntity> vendors;
  const SearchResultsStates({this.vendors = const []});
}

class SearchInitial extends SearchResultsStates {}

///
class SearchLoading extends SearchResultsStates {
  SearchLoading() : super(vendors: Fakers.searchVendors);
}

class SearchSuccess extends SearchResultsStates {
  SearchSuccess({required super.vendors});
}

class SearchError extends SearchResultsStates implements BaseErrorState {
  @override
  String message;
  SearchError({required this.message});
}

///
sealed class LoadMoreResults extends SearchResultsStates {
  LoadMoreResults({super.vendors});
}

class LoadMoreResultsLoading extends SearchResultsStates {
  LoadMoreResultsLoading() : super(vendors: Fakers.searchVendors);
}

class LoadMoreResultsSuccess extends SearchResultsStates {
  LoadMoreResultsSuccess({super.vendors});
}

///
class LoadMoreResultsError extends SearchResultsStates implements BaseErrorState {
  @override
  String message;
  LoadMoreResultsError({required this.message});
}

class SearchFilterState extends SearchState implements Equatable {
  final SearchQuery query;

  const SearchFilterState({required this.query});

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [query];
}
