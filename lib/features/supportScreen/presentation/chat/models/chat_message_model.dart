import 'package:equatable/equatable.dart';

enum MessageSender {
  user,
  support,
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

  bool get hasImage => imageUrl != null || localImagePath != null;

  bool get hasText => text != null && text!.isNotEmpty;

  bool get isFromUser => sender == MessageSender.user;

  bool get isFromSupport => sender == MessageSender.support;

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
