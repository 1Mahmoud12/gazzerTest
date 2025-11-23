import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/pkgs/notification/notification.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/supportScreen/domain/chat_repo.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/cubit/chat_cubit.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/cubit/chat_states.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/models/chat_message_model.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/widgets/chat_app_bar.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/widgets/chat_input_field.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/widgets/chat_message_bubble.dart';
import 'package:gazzer/main.dart';

class GazzerSupportChatScreen extends StatefulWidget {
  const GazzerSupportChatScreen({
    super.key,
    this.chatId,
    this.orderId,
  });

  static const route = '/gazzer-support-chat';

  final int? chatId;
  final int? orderId;

  @override
  State<GazzerSupportChatScreen> createState() => _GazzerSupportChatScreenState();
}

class _GazzerSupportChatScreenState extends State<GazzerSupportChatScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;
  StreamSubscription<RemoteMessage>? _notificationSubscription;
  int? _currentChatId;
  ChatCubit? _chatCubit;

  @override
  void initState() {
    super.initState();
    // Initialize with widget chatId if provided
    _currentChatId = widget.chatId;
    _scrollController.addListener(_onScroll);
    _setupNotificationListener();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _notificationSubscription?.cancel();
    if (_chatCubit != null && !_chatCubit!.isClosed) {
      _chatCubit!.close();
    }
    super.dispose();
  }

  void _setupNotificationListener() {
    // Listen for foreground notifications
    _notificationSubscription = FirebaseMessaging.onMessage.listen((
      RemoteMessage message,
    ) {
      _handleNotification(message);
    });
  }

  void _handleNotification(RemoteMessage message) {
    final data = message.data;
    logger.d('message $data');
    final notificationType = (data['type'] ?? '').toString().toLowerCase();

    // Check if it's a support notification
    if (notificationType == NotificationType.support.name.toLowerCase()) {
      // Try to get chat_id from notification data
      final notificationChatId = _extractChatId(data);

      // Get the current chat_id (from state or widget)
      final currentChatId = _currentChatId ?? widget.chatId;

      // If chat_id matches current chat, refresh messages
      if (notificationChatId != null && currentChatId != null && notificationChatId == currentChatId) {
        // Refresh messages using stored cubit reference
        _chatCubit?.loadChatMessages();
      }
    }
  }

  int? _extractChatId(Map<String, dynamic> data) {
    // Try different possible keys for chat_id
    if (data.containsKey('chat_id')) {
      final chatId = data['chat_id'];
      if (chatId is int) return chatId;
      if (chatId is String) return int.tryParse(chatId);
    }
    return null;
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _isLoadingMore) return;

    final position = _scrollController.position;
    // Trigger pagination when scrolled near the top
    if (position.pixels <= 100) {
      context.read<ChatCubit>().loadMoreMessages();
    }
  }

  void _scrollToBottom({bool animated = true}) {
    if (!_scrollController.hasClients) return;

    Future.delayed(const Duration(milliseconds: 100), () {
      if (!_scrollController.hasClients) return;

      if (animated) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Create cubit and store reference
    final chatCubit = _chatCubit ??= ChatCubit(
      di<ChatRepo>(),
      chatId: widget.chatId,
      orderId: widget.orderId,
    );

    return BlocProvider.value(
      value: chatCubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: const ChatAppBar(),
        body: BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {
            if (state is ChatLoadedState) {
              _isLoadingMore = state.isLoadingMore;

              // Update current chat_id
              if (state.chatId != null) {
                _currentChatId = state.chatId;
              }

              // Only scroll to bottom when:
              // 1. Initial load (not paginating)
              // 2. Sending a new message
              // Don't scroll during pagination (loading more)
              if (!state.isLoadingMore && state.isSending) {
                _scrollToBottom();
              }
            }
          },
          builder: (context, state) {
            if (state is ChatErrorState) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            // Extract data from state
            final messages = state is ChatLoadedState
                ? (List<ChatMessageModel>.from(state.messages)..sort((a, b) => a.timestamp.compareTo(b.timestamp)))
                : <ChatMessageModel>[];

            final isLoadingMore = state is ChatLoadedState ? state.isLoadingMore : false;
            final isSending = state is ChatLoadedState ? state.isSending : false;
            final imagePreviewPath = state is ChatLoadedState ? state.imagePreviewPath : null;
            final chatId = state is ChatLoadedState ? state.chatId : null;
            final hasNoChat = chatId == null;
            return Column(
              children: [
                // Messages List
                Expanded(
                  child: messages.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.chat_bubble_outline,
                                size: 64,
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                hasNoChat ? 'Start a conversation by sending a message' : L10n.tr().noMessagesYet,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          reverse: false,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          itemCount: messages.length + (isLoadingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == 0 && isLoadingMore) {
                              return const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            final messageIndex = isLoadingMore ? index - 1 : index;
                            final message = messages[messageIndex];
                            return ChatMessageBubble(message: message);
                          },
                        ),
                ),
                // Input Field
                ChatInputField(
                  onSendMessage: (text) {
                    context.read<ChatCubit>().sendMessage(text);
                  },
                  onPickImage: () {
                    context.read<ChatCubit>().pickImageFromGallery();
                  },
                  onPickCamera: () {
                    context.read<ChatCubit>().pickImageFromCamera();
                  },
                  isSending: isSending,
                  imagePreviewPath: imagePreviewPath,
                  onRemoveImage: () {
                    context.read<ChatCubit>().removeImagePreview();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
