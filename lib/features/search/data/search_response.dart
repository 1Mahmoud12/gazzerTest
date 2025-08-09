import 'package:gazzer/features/search/data/dtos/search_vendor_dto.dart';
import 'package:gazzer/features/search/domain/search_vendor_entity.dart';

class SearchResponse {
  late final List<SearchVendorEntity> vendors;
  late final int currentPage;
  late final int lastPage;

  SearchResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['pagination']['current_page'] ?? 1;
    lastPage = json['pagination']['total_pages'] ?? 1;
    vendors = (json['data'] as List).map((e) => SearchVendorDTO.fromJson(e).toEntity()).toList();
  }
}
