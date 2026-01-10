import 'package:equatable/equatable.dart';

class ChatResponse extends Equatable {
  final ChatEntity chat;
  final PaginationEntity pagination;

  const ChatResponse({required this.chat, required this.pagination});

  @override
  List<Object?> get props => [chat, pagination];
}

class ChatEntity extends Equatable {
  final int id;
  final String type;
  final String status;
  final String? subject;
  final DateTime? lastMessageAt;
  final DateTime createdAt;
  final int? orderId;
  final List<String>? orderItemIds;
  final List<ChatMessageEntity> messages;

  const ChatEntity({
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

  @override
  List<Object?> get props => [
    id,
    type,
    status,
    subject,
    lastMessageAt,
    createdAt,
    orderId,
    orderItemIds,
    messages,
  ];
}

class ChatMessageEntity extends Equatable {
  final String id;
  final String? text;
  final String? imageUrl;
  final int? senderId;
  final String? senderType;
  final bool? isRead;
  final DateTime? readAt;
  final DateTime timestamp;

  const ChatMessageEntity({
    required this.id,
    this.text,
    this.imageUrl,
    required this.senderId,
    required this.senderType,
    required this.isRead,
    this.readAt,
    required this.timestamp,
  });

  bool get isFromUser => senderType == 'client';

  bool get isFromSystem => senderType == 'system';

  bool get isFromAdmin => senderType == 'admin';

  @override
  List<Object?> get props => [
    id,
    text,
    imageUrl,
    senderId,
    senderType,
    isRead,
    readAt,
    timestamp,
  ];
}

class PaginationEntity extends Equatable {
  final int currentPage;
  final int totalRecords;
  final int currentRecords;
  final bool hasNext;
  final bool hasPrevious;
  final int totalPages;
  final int perPage;

  const PaginationEntity({
    required this.currentPage,
    required this.totalRecords,
    required this.currentRecords,
    required this.hasNext,
    required this.hasPrevious,
    required this.totalPages,
    required this.perPage,
  });

  @override
  List<Object?> get props => [
    currentPage,
    totalRecords,
    currentRecords,
    hasNext,
    hasPrevious,
    totalPages,
    perPage,
  ];
}
