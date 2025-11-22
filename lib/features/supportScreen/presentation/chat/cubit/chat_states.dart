import 'package:gazzer/features/supportScreen/presentation/chat/models/chat_message_model.dart';

sealed class ChatStates {}

final class ChatInitialState extends ChatStates {}

final class ChatLoadingState extends ChatStates {}

final class ChatLoadedState extends ChatStates {
  final List<ChatMessageModel> messages;
  final bool isSending;
  final String? imagePreviewPath;

  ChatLoadedState({
    required this.messages,
    this.isSending = false,
    this.imagePreviewPath,
  });

  ChatLoadedState copyWith({
    List<ChatMessageModel>? messages,
    bool? isSending,
    String? imagePreviewPath,
    bool clearImagePreview = false,
  }) {
    return ChatLoadedState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      imagePreviewPath: clearImagePreview ? null : (imagePreviewPath ?? this.imagePreviewPath),
    );
  }
}

final class ChatErrorState extends ChatStates {
  final String error;

  ChatErrorState(this.error);
}
