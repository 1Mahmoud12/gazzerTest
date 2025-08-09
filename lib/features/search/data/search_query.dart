import 'package:equatable/equatable.dart';
import 'package:gazzer/core/presentation/extensions/enum.dart';

class SearchQuery extends Equatable {
  final String searchWord;
  final int perPage;
  final bool sortedByRate;
  final bool sortByDeliveryTime;
  final bool ascendingAlphabetic;
  final VendorType type;

  final int currentPage;

  const SearchQuery({
    this.searchWord = '',
    this.perPage = 10,
    this.currentPage = 1,
    this.sortedByRate = false,
    this.sortByDeliveryTime = false,
    this.ascendingAlphabetic = false,
    this.type = VendorType.restaurant,
  });

  String toQuery() =>
      '?is_paginated=1&page=$currentPage&search=$searchWord&per_page=$perPage&by_rate=$sortedByRate&by_delivery_time=$sortByDeliveryTime&alpha_order=${ascendingAlphabetic ? 'asc' : 'desc'}&type=${type.value}';

  SearchQuery copyWith({
    String? searchWord,
    int? perPage,
    int? currentPage,
    bool? sortedByRate,
    bool? sortByDeliveryTime,
    bool? ascendingAlphabetic,
    VendorType? type,
  }) {
    return SearchQuery(
      searchWord: searchWord ?? this.searchWord,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      sortedByRate: sortedByRate ?? this.sortedByRate,
      sortByDeliveryTime: sortByDeliveryTime ?? this.sortByDeliveryTime,
      ascendingAlphabetic: ascendingAlphabetic ?? this.ascendingAlphabetic,
      type: type ?? this.type,
    );
  }

  @override
  List<Object?> get props => [
    searchWord,
    perPage,
    currentPage,
    sortedByRate,
    sortByDeliveryTime,
    ascendingAlphabetic,
    type,
  ];
}
