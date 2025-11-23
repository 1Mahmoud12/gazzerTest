import 'package:gazzer/features/supportScreen/domain/entities/chat_entity.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/models/chat_message_model.dart';

sealed class ChatStates {}

final class ChatInitialState extends ChatStates {}

final class ChatLoadingState extends ChatStates {}

final class ChatLoadedState extends ChatStates {
  final List<ChatMessageModel> messages;
  final bool isSending;
  final String? imagePreviewPath;
  final int? chatId;
  final int? orderId;
  final PaginationEntity? pagination;
  final bool isLoadingMore;

  ChatLoadedState({
    required this.messages,
    this.isSending = false,
    this.imagePreviewPath,
    this.chatId,
    this.orderId,
    this.pagination,
    this.isLoadingMore = false,
  });

  bool get hasMorePages => pagination?.hasNext ?? false;

  int get currentPage => pagination?.currentPage ?? 1;

  ChatLoadedState copyWith({
    List<ChatMessageModel>? messages,
    bool? isSending,
    String? imagePreviewPath,
    bool clearImagePreview = false,
    int? chatId,
    int? orderId,
    PaginationEntity? pagination,
    bool? isLoadingMore,
  }) {
    return ChatLoadedState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      imagePreviewPath: clearImagePreview ? null : (imagePreviewPath ?? this.imagePreviewPath),
      chatId: chatId ?? this.chatId,
      orderId: orderId ?? this.orderId,
      pagination: pagination ?? this.pagination,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

final class ChatErrorState extends ChatStates {
  final String error;

  ChatErrorState(this.error);
}
