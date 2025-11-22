import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/theme/app_theme.dart';
import 'package:gazzer/features/supportScreen/presentation/chat/models/chat_message_model.dart';
import 'package:intl/intl.dart';

class ChatMessageBubble extends StatelessWidget {
  final ChatMessageModel message;

  const ChatMessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isFromUser;
    final bubbleColor = isUser ? const Color(0xFFE8E8E8) : const Color(0xFFEBE3FE);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isUser ? 16 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Image if present
                  if (message.hasImage) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: message.localImagePath != null
                          ? Image.file(
                              File(message.localImagePath!),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              message.imageUrl!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Container(
                                  height: 150,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                    ),
                    if (message.hasText) const SizedBox(height: 8),
                  ],
                  // Text if present
                  if (message.hasText)
                    Text(
                      message.text!,
                      style: TStyle.blackRegular(14).copyWith(
                        color: Colors.black87,
                      ),
                    ),
                  const SizedBox(height: 4),
                  // Timestamp and status
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.timestamp),
                        style: TStyle.blackRegular(11).copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 4),
                        _buildStatusIcon(),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon() {
    switch (message.status) {
      case MessageStatus.sending:
        return const SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
          ),
        );
      case MessageStatus.sent:
        return const Icon(Icons.check, size: 14, color: Colors.black54);
      case MessageStatus.delivered:
        return const Icon(Icons.done_all, size: 14, color: Colors.black54);
      case MessageStatus.read:
        return const Icon(Icons.done_all, size: 14, color: Colors.blue);
      case MessageStatus.failed:
        return const Icon(Icons.error_outline, size: 14, color: Colors.red);
    }
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      // Today - show time
      return DateFormat('HH:mm a').format(dateTime);
    } else if (difference.inDays == 1) {
      // Yesterday
      return '${L10n.tr().yesterday} ${DateFormat('HH:mm a').format(dateTime)}';
    } else {
      // Other days
      return DateFormat('MMM dd, HH:mm a').format(dateTime);
    }
  }
}
