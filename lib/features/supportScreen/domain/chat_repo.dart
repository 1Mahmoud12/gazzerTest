import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/requests/send_message_request.dart';
import 'package:gazzer/features/supportScreen/domain/entities/chat_entity.dart';

class SendMessageResponse {
  final ChatMessageEntity? message;
  final int? chatId;
  final List<ChatMessageEntity>? messages;

  SendMessageResponse({
    this.message,
    this.chatId,
    this.messages,
  });
}

abstract class ChatRepo extends BaseApiRepo {
  ChatRepo(super.crashlyticsRepo);

  Future<Result<ChatResponse>> getChatMessages(int chatId, {int page = 1});

  Future<Result<SendMessageResponse>> sendMessage(SendMessageRequest request);
}
