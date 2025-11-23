import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/dto/chat_dto.dart';
import 'package:gazzer/features/supportScreen/data/dto/send_message_response_dto.dart';
import 'package:gazzer/features/supportScreen/data/requests/send_message_request.dart';
import 'package:gazzer/features/supportScreen/domain/chat_repo.dart';
import 'package:gazzer/features/supportScreen/domain/entities/chat_entity.dart';

enum SupportEnum {
  general,
  order_issue,
}

class ChatRepoImp extends ChatRepo {
  final ApiClient _apiClient;

  ChatRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<ChatResponse>> getChatMessages(int chatId, {int page = 1}) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.getChatMessages(chatId),
        queryParameters: {
          'is_paginated': 1,
          'page': page,
        },
      ),
      parser: (response) {
        return ChatResponseDTO.fromJson(response.data).toEntity();
      },
    );
  }

  @override
  Future<Result<SendMessageResponse>> sendMessage(SendMessageRequest request) {
    if (!request.isValid) {
      return Future.value(
        Err(
          BaseError(
            message: 'Invalid request: must have chat_id or order_id, and message or attachment',
            e: ErrorType.badResponse,
          ),
        ),
      );
    }

    return super.call(
      apiCall: () async {
        if (request.attachment != null) {
          // Send with file upload
          final formData = FormData.fromMap({
            if (request.chatId != null) 'chat_id': request.chatId,
            if (request.orderId != null) 'order_id': request.orderId,
            'type': request.orderId != null ? SupportEnum.order_issue.name : SupportEnum.general.name,
            if (request.message != null && request.message!.trim().isNotEmpty) 'message': request.message!.trim(),
            'attachment': await MultipartFile.fromFile(
              request.attachment!.path,
            ),
          });

          return _apiClient.post(
            endpoint: Endpoints.sendChatMessage,
            requestBody: formData,
          );
        } else {
          // Send without file
          return _apiClient.post(
            endpoint: Endpoints.sendChatMessage,
            requestBody: {
              if (request.chatId != null) 'chat_id': request.chatId,
              if (request.orderId != null) 'order_id': request.orderId,
              'type': request.orderId != null ? SupportEnum.order_issue.name : SupportEnum.general.name,

              if (request.message != null && request.message!.trim().isNotEmpty) 'message': request.message!.trim(),
            },
          );
        }
      },
      parser: (response) {
        // API returns the chat data with id and messages array
        final responseDTO = SendMessageResponseDTO.fromJson(response.data);
        return SendMessageResponse(
          message: responseDTO.message?.toEntity(),
          chatId: responseDTO.chatId,
          messages: responseDTO.messages?.map((m) => m.toEntity()).toList(),
        );
      },
    );
  }
}
