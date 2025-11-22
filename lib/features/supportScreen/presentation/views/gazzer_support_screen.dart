import 'package:flutter/material.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/views/gazzer_support_chat_screen.dart';

/// Legacy support screen - now redirects to chat
class GazzerSupportScreen extends StatelessWidget {
  const GazzerSupportScreen({super.key});

  static const route = '/gazzer-support';

  @override
  Widget build(BuildContext context) {
    // Redirect to new chat screen
    return const GazzerSupportChatScreen();
  }
}
