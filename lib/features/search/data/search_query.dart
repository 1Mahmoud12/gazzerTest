import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

enum AlphaSort {
  asc,
  desc,
  none;

  String get name {
    switch (this) {
      case AlphaSort.asc:
        return 'asc';
      case AlphaSort.desc:
        return 'desc';
      case AlphaSort.none:
        return '';
    }
  }

  String get uncodeIcon {
    switch (this) {
      case AlphaSort.asc:
        return '\u2191';
      case AlphaSort.desc:
        return '\u2193';
      case AlphaSort.none:
        return '';
    }
  }

  AlphaSort next() {
    switch (this) {
      case AlphaSort.asc:
        return AlphaSort.desc;
      case AlphaSort.desc:
        return AlphaSort.none;
      case AlphaSort.none:
        return AlphaSort.asc;
    }
  }
}

class SearchQuery extends Equatable {
  final String searchWord;
  final int perPage;
  final bool sortedByRate;
  final bool sortByDeliveryTime;
  final AlphaSort alpha;
  final int? categoryId;

  final int currentPage;

  const SearchQuery({
    this.searchWord = '',
    this.perPage = 10,
    this.currentPage = 1,
    this.sortedByRate = false,
    this.sortByDeliveryTime = false,
    this.alpha = AlphaSort.none,
    this.categoryId,
  });

  String toQuery() =>
      '?is_paginated=1&page=$currentPage&search=$searchWord&per_page=$perPage&by_rate=${sortedByRate ? 1 : 0}&by_delivery_time=${sortByDeliveryTime ? 1 : 0}&alpha_order=${alpha.name}&category_id=$categoryId';

  SearchQuery copyWith({
    String? searchWord,
    int? perPage,
    int? currentPage,
    bool? sortedByRate,
    bool? sortByDeliveryTime,
    AlphaSort? alpha,
    VendorType? type,
    int? categoryId,
  }) {
    return SearchQuery(
      searchWord: searchWord ?? this.searchWord,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      sortedByRate: sortedByRate ?? this.sortedByRate,
      sortByDeliveryTime: sortByDeliveryTime ?? this.sortByDeliveryTime,
      alpha: alpha ?? this.alpha,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  @override
  List<Object?> get props => [
    searchWord,
    perPage,
    currentPage,
    sortedByRate,
    sortByDeliveryTime,
    alpha,
    categoryId,
  ];
}
