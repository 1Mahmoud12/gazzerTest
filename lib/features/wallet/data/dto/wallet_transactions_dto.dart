import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_transactions_entity.dart';

class WalletTransactionsResponseDto {
  WalletTransactionsResponseDto({required this.status, required this.message, required this.pagination, required this.data});

  final String? status;
  final String? message;
  final PaginationDto? pagination;
  final List<TransactionDto> data;

  factory WalletTransactionsResponseDto.fromJson(Map<String, dynamic> json) {
    return WalletTransactionsResponseDto(
      status: json['status'] as String?,
      message: json['message'] as String?,
      pagination: json['pagination'] == null ? null : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>?)?.map((e) => TransactionDto.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
    );
  }

  WalletTransactionsResponse toEntity() =>
      WalletTransactionsResponse(pagination: pagination?.toEntity(), transactions: data.map((e) => e.toEntity()).toList());
}

class PaginationDto {
  PaginationDto({required this.currentPage, required this.lastPage, required this.perPage, required this.total});

  final int currentPage;
  final int lastPage;
  final int perPage;
  final int total;

  factory PaginationDto.fromJson(Map<String, dynamic> json) {
    return PaginationDto(
      currentPage: json['current_page'] as int? ?? 1,
      lastPage: json['last_page'] as int? ?? 1,
      perPage: json['per_page'] as int? ?? 15,
      total: json['total'] as int? ?? 0,
    );
  }

  PaginationEntity toEntity() => PaginationEntity(currentPage: currentPage, lastPage: lastPage, perPage: perPage, total: total);
}

class TransactionDto {
  TransactionDto({
    required this.id,
    required this.clientWalletId,
    required this.clientId,
    required this.type,
    required this.amount,
    required this.currency,
    required this.source,
    required this.referenceId,
    required this.referenceType,
    required this.paymobOrderId,
    required this.metadata,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final int clientWalletId;
  final int clientId;
  final String type;
  final num amount;
  final String currency;
  final String source;
  final int? referenceId;
  final String? referenceType;
  final int? paymobOrderId;
  final Map<String, dynamic>? metadata;
  final String? note;
  final String createdAt;
  final String updatedAt;

  factory TransactionDto.fromJson(Map<String, dynamic> json) {
    return TransactionDto(
      id: json['id'] as int? ?? 0,
      clientWalletId: json['client_wallet_id'] as int? ?? 0,
      clientId: json['client_id'] as int? ?? 0,
      type: json['type'] as String? ?? '',
      amount: json['amount'] as num? ?? 0,

      currency: json['currency'] as String? ?? '',
      source: json['source'] as String? ?? '',
      referenceId: json['reference_id'] as int?,
      referenceType: json['reference_type'] as String?,
      paymobOrderId: json['paymob_order_id'] as int?,
      metadata: json['metadata'] as Map<String, dynamic>?,
      note: json['note'] as String?,
      createdAt: json['created_at'] as String? ?? '',
      updatedAt: json['updated_at'] as String? ?? '',
    );
  }

  TransactionEntity toEntity() => TransactionEntity(
    id: id,
    type: type,
    amount: amount.toDouble(),

    currency: currency,
    source: source,
    note: note,
    createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
    metadata: metadata,
  );
}
