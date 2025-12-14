class PaginationInfo {
  final int currentPage;
  final int totalPages;
  final int totalRecords;
  final int currentRecords;
  final bool hasNext;
  final bool hasPrevious;
  final int perPage;

  PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalRecords,
    required this.currentRecords,
    required this.hasNext,
    required this.hasPrevious,
    required this.perPage,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      currentPage: json['current_page'] ?? 1,
      totalPages: json['total_pages'] ?? 1,
      totalRecords: json['total_records'] ?? 0,
      currentRecords: json['current_records'] ?? 0,
      hasNext: json['has_next'] ?? false,
      hasPrevious: json['has_previous'] ?? false,
      perPage: json['per_page'] ?? 10,
    );
  }

  Map<String, dynamic> toJson() => {
    'current_page': currentPage,
    'total_pages': totalPages,
    'total_records': totalRecords,
    'current_records': currentRecords,
    'has_next': hasNext,
    'has_previous': hasPrevious,
    'per_page': perPage,
  };
}
