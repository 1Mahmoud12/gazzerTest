import 'order_detail_dto.dart';

class OrderDetailResponseDto {
  String? status;
  String? message;
  OrderDetailDto? data;

  OrderDetailResponseDto({this.status, this.message, this.data});

  factory OrderDetailResponseDto.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? OrderDetailDto.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }
}
