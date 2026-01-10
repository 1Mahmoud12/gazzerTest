import 'package:gazzer/features/supportScreen/data/dto/chat_dto.dart';

class SendMessageResponseDTO {
  final ChatMessageDTO? message;
  final int? chatId;
  final List<ChatMessageDTO>? messages;

  SendMessageResponseDTO({this.message, this.chatId, this.messages});

  factory SendMessageResponseDTO.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>?;
    final chatId = data?['id'] as int?;

    // Extract messages from data.messages array
    List<ChatMessageDTO>? messagesList;
    if (data?['messages'] != null) {
      messagesList = (data!['messages'] as List<dynamic>)
          .map((msg) => ChatMessageDTO.fromJson(msg as Map<String, dynamic>))
          .toList();
    }

    // Get the last message (the one we just sent) or first message from messages array
    ChatMessageDTO? messageDto;
    if (messagesList != null && messagesList.isNotEmpty) {
      // The last message in the array is the one we just sent
      messageDto = messagesList.last;
    } else if (data?['last_message'] != null) {
      messageDto = ChatMessageDTO.fromJson(
        data!['last_message'] as Map<String, dynamic>,
      );
    }

    return SendMessageResponseDTO(
      message: messageDto,
      chatId: chatId,
      messages: messagesList,
    );
  }
}
