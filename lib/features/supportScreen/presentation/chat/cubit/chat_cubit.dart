import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/supportScreen/data/requests/send_message_request.dart';
import 'package:gazzer/features/supportScreen/domain/chat_repo.dart';
import 'package:gazzer/features/supportScreen/domain/entities/chat_entity.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/cubit/chat_states.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/models/chat_message_model.dart';
import 'package:image_picker/image_picker.dart';

class ChatCubit extends Cubit<ChatStates> {
  final ChatRepo _repo;
  final ImagePicker _imagePicker = ImagePicker();
  int? _chatId;
  final int? orderId;
  ChatLoadedState? _currentLoadedState;

  ChatCubit(this._repo, {int? chatId, this.orderId}) : _chatId = chatId, super(ChatInitialState()) {
    if (_chatId != null) {
      loadChatMessages();
    } else {
      // No chat_id - show empty state where user can start a new chat
      _currentLoadedState = ChatLoadedState(
        messages: [],
        chatId: null,
        orderId: orderId,
      );
      emit(_currentLoadedState!);
    }
  }

  Future<void> loadChatMessages({int page = 1}) async {
    if (_chatId == null) return;

    if (page == 1) {
      emit(ChatLoadingState());
    } else if (_currentLoadedState != null) {
      emit(_currentLoadedState!.copyWith(isLoadingMore: true));
    }

    final result = await _repo.getChatMessages(_chatId!, page: page);
    switch (result) {
      case Ok<ChatResponse> ok:
        final chatResponse = ok.value;
        final messages = chatResponse.chat.messages.map((e) => ChatMessageModel.fromEntity(e)).toList();

        if (_currentLoadedState != null && page > 1) {
          // Loading more - prepend old messages
          final allMessages = [...messages, ..._currentLoadedState!.messages];
          _currentLoadedState = _currentLoadedState!.copyWith(
            messages: allMessages,
            chatId: chatResponse.chat.id,
            pagination: chatResponse.pagination,
            isLoadingMore: false,
          );
          emit(_currentLoadedState!);
        } else {
          // First load or refresh
          _currentLoadedState = ChatLoadedState(
            messages: messages,
            chatId: chatResponse.chat.id,
            orderId: orderId,
            pagination: chatResponse.pagination,
          );
          emit(_currentLoadedState!);
        }
        // Update internal chatId
        _chatId = chatResponse.chat.id;
        break;
      case Err<ChatResponse> err:
        emit(ChatErrorState(err.error.message));
        break;
    }
  }

  Future<void> loadMoreMessages() async {
    if (_currentLoadedState == null) return;

    // Prevent multiple simultaneous pagination requests
    if (_currentLoadedState!.isLoadingMore) return;

    // Check if there are more pages to load
    if (!_currentLoadedState!.hasMorePages) return;

    await loadChatMessages(page: _currentLoadedState!.currentPage + 1);
  }

  Future<void> sendMessage(String text) async {
    if (_currentLoadedState == null) return;

    if (text.trim().isEmpty && _currentLoadedState!.imagePreviewPath == null) return;

    // Set sending state
    _currentLoadedState = _currentLoadedState!.copyWith(isSending: true);
    emit(_currentLoadedState!);

    // Create temporary message for UI
    final tempMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim().isEmpty ? null : text.trim(),
      localImagePath: _currentLoadedState!.imagePreviewPath,
      sender: MessageSender.user,
      status: MessageStatus.sending,
      timestamp: DateTime.now(),
    );

    final updatedMessages = [..._currentLoadedState!.messages, tempMessage];
    _currentLoadedState = _currentLoadedState!.copyWith(
      messages: updatedMessages,
      isSending: true,
    );
    emit(_currentLoadedState!);

    // Prepare file if exists
    File? attachmentFile;
    if (_currentLoadedState!.imagePreviewPath != null) {
      attachmentFile = File(_currentLoadedState!.imagePreviewPath!);
    }

    // Send to API
    final request = SendMessageRequest(
      chatId: _currentLoadedState!.chatId,
      orderId: _currentLoadedState!.orderId,
      message: text.trim().isEmpty ? null : text.trim(),
      attachment: attachmentFile,
      type: _currentLoadedState!.orderId != null ? 'order_issue' : 'general',
    );

    final result = await _repo.sendMessage(request);
    switch (result) {
      case Ok<SendMessageResponse> ok:
        // Update chat_id from response
        if (ok.value.chatId != null) {
          _chatId = ok.value.chatId;
        }

        // Handle response - use messages from API response if available
        if (ok.value.messages != null && ok.value.messages!.isNotEmpty) {
          // Use messages from response (more efficient than re-fetching)
          final sentMessages = ok.value.messages!.map((e) => ChatMessageModel.fromEntity(e)).toList();

          _currentLoadedState = _currentLoadedState!.copyWith(
            messages: sentMessages,
            chatId: ok.value.chatId,
            isSending: false,
            clearImagePreview: true,
          );
          emit(_currentLoadedState!);
        } else {
          // Update temp message to sent status
          final sentMessages = updatedMessages.map((m) {
            if (m.id == tempMessage.id) {
              return m.copyWith(status: MessageStatus.sent);
            }
            return m;
          }).toList();

          _currentLoadedState = _currentLoadedState!.copyWith(
            messages: sentMessages,
            chatId: ok.value.chatId ?? _currentLoadedState!.chatId,
            isSending: false,
            clearImagePreview: true,
          );
          emit(_currentLoadedState!);
        }
        break;
      case Err<SendMessageResponse> err:
        // Update message status to failed
        final failedMessages = updatedMessages
            .map(
              (m) => m.id == tempMessage.id ? m.copyWith(status: MessageStatus.failed) : m,
            )
            .toList();

        _currentLoadedState = _currentLoadedState!.copyWith(
          messages: failedMessages,
          isSending: false,
        );
        emit(_currentLoadedState!);
        Alerts.showToast(err.error.message);
        break;
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null && _currentLoadedState != null) {
        _currentLoadedState = _currentLoadedState!.copyWith(
          imagePreviewPath: image.path,
        );
        emit(_currentLoadedState!);
      }
    } catch (e) {
      Alerts.showToast('Error picking image');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null && _currentLoadedState != null) {
        _currentLoadedState = _currentLoadedState!.copyWith(
          imagePreviewPath: image.path,
        );
        emit(_currentLoadedState!);
      }
    } catch (e) {
      Alerts.showToast('Error taking photo');
    }
  }

  void removeImagePreview() {
    if (_currentLoadedState != null) {
      _currentLoadedState = _currentLoadedState!.copyWith(
        clearImagePreview: true,
      );
      emit(_currentLoadedState!);
    }
  }

  @override
  void emit(ChatStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
