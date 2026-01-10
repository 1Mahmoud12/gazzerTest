import 'dart:io';

class SendMessageRequest {
  final int? chatId;
  final int? orderId;
  final String? message;
  final String? type;
  final File? attachment;

  SendMessageRequest({
    this.type,
    this.chatId,
    this.orderId,
    this.message,
    this.attachment,
  });

  bool get isValid {
    // Must have at least one of chat_id or order_id
    if (chatId == null && orderId == null) return false;
    // Must have at least one of message or attachment
    if ((message == null || message!.trim().isEmpty) && attachment == null)
      return false;
    return true;
  }
}
