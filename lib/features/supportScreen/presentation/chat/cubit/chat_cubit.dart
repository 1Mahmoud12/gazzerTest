import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/cubit/chat_states.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/models/chat_message_model.dart';
import 'package:image_picker/image_picker.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState()) {
    _initializeChat();
  }

  final List<ChatMessageModel> _messages = [];
  final ImagePicker _imagePicker = ImagePicker();

  void _initializeChat() {
    // Initialize with welcome message from support
    final welcomeMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: L10n.tr().welcomeMessage,
      sender: MessageSender.support,
      status: MessageStatus.delivered,
      timestamp: DateTime.now(),
    );

    _messages.add(welcomeMessage);
    emit(ChatLoadedState(messages: List.from(_messages)));
  }

  Future<void> sendMessage(String text) async {
    if (state is! ChatLoadedState) return;
    final currentState = state as ChatLoadedState;

    if (text.trim().isEmpty && currentState.imagePreviewPath == null) return;

    // Set sending state
    emit(currentState.copyWith(isSending: true));

    // Create new message
    final message = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim().isEmpty ? null : text.trim(),
      localImagePath: currentState.imagePreviewPath,
      sender: MessageSender.user,
      status: MessageStatus.sending,
      timestamp: DateTime.now(),
    );

    _messages.add(message);
    emit(
      ChatLoadedState(
        messages: List.from(_messages),
        isSending: true,
      ),
    );

    // Simulate sending delay (Replace with actual API call)
    await Future.delayed(const Duration(seconds: 1));

    // Update message status to sent
    final index = _messages.indexWhere((m) => m.id == message.id);
    if (index != -1) {
      _messages[index] = message.copyWith(status: MessageStatus.sent);
    }

    emit(
      ChatLoadedState(
        messages: List.from(_messages),
        isSending: false,
      ),
    );

    // Simulate support response after 2 seconds
    _simulateSupportResponse();
  }

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null && state is ChatLoadedState) {
        final currentState = state as ChatLoadedState;
        emit(currentState.copyWith(imagePreviewPath: image.path));
      }
    } catch (e) {
      // Handle error silently or show toast
      log('Error picking image: $e');
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null && state is ChatLoadedState) {
        final currentState = state as ChatLoadedState;
        emit(currentState.copyWith(imagePreviewPath: image.path));
      }
    } catch (e) {
      // Handle error silently or show toast
      log('Error taking photo: $e');
    }
  }

  void removeImagePreview() {
    if (state is ChatLoadedState) {
      final currentState = state as ChatLoadedState;
      emit(currentState.copyWith(clearImagePreview: true));
    }
  }

  void _simulateSupportResponse() {
    // Simulate support response (Replace with actual API integration)
    Future.delayed(const Duration(seconds: 2), () {
      if (state is ChatLoadedState) {
        final responses = [
          'Thank you for reaching out! I\'m checking on that for you.',
          'I understand your concern. Let me help you with that.',
          'Got it! I\'ll assist you right away.',
          'Thanks for the information. I\'m looking into this now.',
        ];

        final randomResponse = responses[_messages.length % responses.length];

        final supportMessage = ChatMessageModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          text: randomResponse,
          sender: MessageSender.support,
          status: MessageStatus.delivered,
          timestamp: DateTime.now(),
        );

        _messages.add(supportMessage);
        emit(ChatLoadedState(messages: List.from(_messages)));
      }
    });
  }

  @override
  void emit(ChatStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
