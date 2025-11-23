import 'package:flutter/material.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/views/gazzer_support_chat_screen.dart';

/// Legacy support screen - now redirects to chat
/// Can be called with chatId (to load existing chat) or orderId (to start new chat)
class GazzerSupportScreen extends StatelessWidget {
  const GazzerSupportScreen({super.key, this.chatId, this.orderId});

  static const route = '/gazzer-support';

  final int? chatId;
  final int? orderId;

  @override
  Widget build(BuildContext context) {
    // Redirect to new chat screen
    return GazzerSupportChatScreen(
      chatId: chatId,
      orderId: orderId,
    );
  }
}
