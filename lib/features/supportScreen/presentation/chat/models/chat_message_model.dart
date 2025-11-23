import 'package:equatable/equatable.dart';
import 'package:gazzer/features/supportScreen/domain/entities/chat_entity.dart';

enum MessageSender {
  user,
  support,
  system,
}

enum MessageStatus {
  sending,
  sent,
  delivered,
  read,
  failed,
}

class ChatMessageModel extends Equatable {
  final String id;
  final String? text;
  final String? imageUrl;
  final String? localImagePath; // For local images before upload
  final MessageSender sender;
  final MessageStatus status;
  final DateTime timestamp;

  const ChatMessageModel({
    required this.id,
    this.text,
    this.imageUrl,
    this.localImagePath,
    required this.sender,
    required this.status,
    required this.timestamp,
  });

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    MessageSender sender;
    if (entity.isFromUser) {
      sender = MessageSender.user;
    } else if (entity.isFromSystem) {
      sender = MessageSender.system;
    } else {
      sender = MessageSender.support;
    }

    MessageStatus status;
    if (entity.isRead ?? false) {
      status = MessageStatus.read;
    } else {
      status = MessageStatus.delivered;
    }

    return ChatMessageModel(
      id: entity.id,
      text: entity.text,
      imageUrl: entity.imageUrl,
      sender: sender,
      status: status,
      timestamp: entity.timestamp,
    );
  }

  bool get hasImage => imageUrl != null || localImagePath != null;

  bool get hasText => text != null && text!.isNotEmpty;

  bool get isFromUser => sender == MessageSender.user;

  bool get isFromSupport => sender == MessageSender.support || sender == MessageSender.system;

  bool get isSending => status == MessageStatus.sending;

  ChatMessageModel copyWith({
    String? id,
    String? text,
    String? imageUrl,
    String? localImagePath,
    MessageSender? sender,
    MessageStatus? status,
    DateTime? timestamp,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      imageUrl: imageUrl ?? this.imageUrl,
      localImagePath: localImagePath ?? this.localImagePath,
      sender: sender ?? this.sender,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  List<Object?> get props => [
    id,
    text,
    imageUrl,
    localImagePath,
    sender,
    status,
    timestamp,
  ];
}
