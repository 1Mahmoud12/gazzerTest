import 'package:gazzer/features/supportScreen/domain/entities/chat_entity.dart';

class ChatResponseDTO {
  final ChatDataDTO data;
  final PaginationDTO pagination;

  ChatResponseDTO({
    required this.data,
    required this.pagination,
  });

  factory ChatResponseDTO.fromJson(Map<String, dynamic> json) {
    return ChatResponseDTO(
      data: ChatDataDTO.fromJson(json['data']),
      pagination: PaginationDTO.fromJson(json['pagination']),
    );
  }

  ChatResponse toEntity() {
    return ChatResponse(
      chat: data.toEntity(),
      pagination: pagination.toEntity(),
    );
  }
}

class ChatDataDTO {
  final int id;
  final String type;
  final String status;
  final String? subject;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final int? orderId;
  final List<String>? orderItemIds;
  final List<ChatMessageDTO> messages;

  ChatDataDTO({
    required this.id,
    required this.type,
    required this.status,
    this.subject,
    this.lastMessageAt,
    required this.createdAt,
    this.orderId,
    this.orderItemIds,
    required this.messages,
  });

  factory ChatDataDTO.fromJson(Map<String, dynamic> json) {
    return ChatDataDTO(
      id: json['id'] as int,
      type: json['type'] as String,
      status: json['status'] as String,
      subject: json['subject'] as String?,
      lastMessageAt: json['last_message_at'] != null ? DateTime.parse(json['last_message_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
      orderId: json['order_id'] as int?,
      orderItemIds: json['order_item_ids'] != null ? (json['order_item_ids'] as List).map((e) => e.toString()).toList() : null,
      messages: (json['messages'] as List<dynamic>?)?.map((msg) => ChatMessageDTO.fromJson(msg as Map<String, dynamic>)).toList() ?? [],
    );
  }

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      type: type,
      status: status,
      subject: subject,
      lastMessageAt: lastMessageAt,
      createdAt: createdAt,
      orderId: orderId,
      orderItemIds: orderItemIds,
      messages: messages.map((m) => m.toEntity()).toList(),
    );
  }
}

class ChatMessageDTO {
  final int id;
  final String? message;
  final String? attachment;
  final int? senderId;
  final String? senderType;
  final bool? isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  ChatMessageDTO({
    required this.id,
    this.message,
    this.attachment,
    required this.senderId,
    required this.senderType,
    required this.isRead,
    this.readAt,
    required this.createdAt,
  });

  factory ChatMessageDTO.fromJson(Map<String, dynamic> json) {
    return ChatMessageDTO(
      id: json['id'] as int,
      message: json['message'] as String?,
      attachment: json['attachment'] as String?,
      senderId: json['sender_id'] as int?,
      senderType: json['sender_type'] as String?,
      isRead: json['is_read'] as bool?,
      readAt: json['read_at'] != null ? DateTime.parse(json['read_at'] as String) : null,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  ChatMessageEntity toEntity() {
    return ChatMessageEntity(
      id: id.toString(),
      text: message,
      imageUrl: attachment,
      senderId: senderId,
      senderType: senderType,
      isRead: isRead,
      readAt: readAt,
      timestamp: createdAt,
    );
  }
}

class PaginationDTO {
  final int currentPage;
  final int totalRecords;
  final int currentRecords;
  final bool hasNext;
  final bool hasPrevious;
  final int totalPages;
  final int perPage;

  PaginationDTO({
    required this.currentPage,
    required this.totalRecords,
    required this.currentRecords,
    required this.hasNext,
    required this.hasPrevious,
    required this.totalPages,
    required this.perPage,
  });

  factory PaginationDTO.fromJson(Map<String, dynamic> json) {
    return PaginationDTO(
      currentPage: json['current_page'] as int,
      totalRecords: json['total_records'] as int,
      currentRecords: json['current_records'] as int,
      hasNext: json['has_next'] as bool,
      hasPrevious: json['has_previous'] as bool,
      totalPages: json['total_pages'] as int,
      perPage: json['per_page'] as int,
    );
  }

  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      totalRecords: totalRecords,
      currentRecords: currentRecords,
      hasNext: hasNext,
      hasPrevious: hasPrevious,
      totalPages: totalPages,
      perPage: perPage,
    );
  }
}
