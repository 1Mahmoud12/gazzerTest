import 'order_dto.dart';

class OrdersResponseDto {
  String? status;
  String? message;
  PaginationDto? pagination;
  List<OrderDto>? data;

  OrdersResponseDto({this.status, this.message, this.pagination, this.data});

  factory OrdersResponseDto.fromJson(Map<String, dynamic> json) {
    final List<OrderDto> data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        final item = OrderDto.fromJson(v);

        if (item.stores?.isNotEmpty ?? false) data.add(item);
      });
    }
    return OrdersResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      pagination: json['pagination'] != null
          ? PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>)
          : null,
      data: data,
    );
  }
}

class PaginationDto {
  int? currentPage;
  int? totalRecords;
  int? currentRecords;
  bool? hasNext;
  bool? hasPrevious;
  int? totalPages;
  int? perPage;

  PaginationDto({
    this.currentPage,
    this.totalRecords,
    this.currentRecords,
    this.hasNext,
    this.hasPrevious,
    this.totalPages,
    this.perPage,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      currentPage: json['current_page'] as int?,
      totalRecords: json['total_records'] as int?,
      currentRecords: json['current_records'] as int?,
      hasNext: json['has_next'] as bool?,
      hasPrevious: json['has_previous'] as bool?,
      totalPages: json['total_pages'] as int?,
      perPage: json['per_page'] as int?,
    );
  }
}
