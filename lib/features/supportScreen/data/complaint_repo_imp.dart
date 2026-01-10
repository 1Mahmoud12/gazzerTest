import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/requests/complaint_request.dart';
import 'package:gazzer/features/supportScreen/domain/complaint_repo.dart';

class ComplaintResponseDTO {
  final int id;
  final String message;

  ComplaintResponseDTO({required this.id, required this.message});

  factory ComplaintResponseDTO.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;
    return ComplaintResponseDTO(id: data['id'] ?? 0, message: data['message'] ?? json['message'] ?? 'Complaint submitted successfully');
  }

  ComplaintResponse toEntity() {
    return ComplaintResponse(id: id, message: message);
  }
}

class ComplaintRepoImp extends ComplaintRepo {
  final ApiClient _apiClient;

  ComplaintRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<ComplaintResponse>> submitComplaint(ComplaintRequest request) {
    if (!request.isValid) {
      return Future.value(Err(BaseError(message: 'Invalid request: order_item_ids cannot be empty', e: ErrorType.badResponse)));
    }

    return super.call(
      apiCall: () async {
        final hasAttachments = (request.attachments != null && request.attachments!.isNotEmpty) || request.attachment != null;

        if (hasAttachments) {
          // Send with file upload
          final formDataMap = <String, dynamic>{
            'order_id': request.orderId,
            'type': request.type.value,
            if (request.note != null && request.note!.trim().isNotEmpty) 'note': request.note!.trim(),
          };

          // Add single attachment (for backward compatibility)
          if (request.attachment != null) {
            formDataMap['attachment'] = await MultipartFile.fromFile(request.attachment!.path);
          }

          // Add multiple attachments as array
          if (request.attachments != null && request.attachments!.isNotEmpty) {
            for (int i = 0; i < request.attachments!.length; i++) {
              formDataMap['attachment[$i]'] = await MultipartFile.fromFile(request.attachments![i].path);
            }
          }

          // Add order_item_ids array
          for (int i = 0; i < request.orderItemIds.length; i++) {
            formDataMap['order_item_ids[$i]'] = request.orderItemIds[i];
          }

          // Add order_item_count array if provided
          if (request.orderItemCounts != null && request.orderItemCounts!.isNotEmpty) {
            for (int i = 0; i < request.orderItemCounts!.length; i++) {
              formDataMap['order_item_count[$i]'] = request.orderItemCounts![i];
            }
          }

          final formData = FormData.fromMap(formDataMap);

          return _apiClient.post(endpoint: Endpoints.submitComplaint, requestBody: formData);
        } else {
          // Send without file
          final requestBody = <String, dynamic>{
            'order_id': request.orderId,
            'type': request.type.value,
            if (request.note != null && request.note!.trim().isNotEmpty) 'note': request.note!.trim(),
          };

          // Add order_item_ids array
          for (int i = 0; i < request.orderItemIds.length; i++) {
            requestBody['order_item_ids[$i]'] = request.orderItemIds[i];
          }

          // Add order_item_count array if provided
          if (request.orderItemCounts != null && request.orderItemCounts!.isNotEmpty) {
            for (int i = 0; i < request.orderItemCounts!.length; i++) {
              requestBody['order_item_count[$i]'] = request.orderItemCounts![i];
            }
          }

          return _apiClient.post(endpoint: Endpoints.submitComplaint, requestBody: requestBody);
        }
      },
      parser: (response) {
        return ComplaintResponseDTO.fromJson(response.data).toEntity();
      },
    );
  }
}
