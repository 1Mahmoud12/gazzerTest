import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';

class ClientResponse {
  String? message;
  late final ClientEntity client;

  late final String accessToken;
  int? expiresIn;
  // String? tokenType;

  ClientResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final data = json['data'];
      accessToken = data['access_token'];
      // tokenType = data['token_type'];
      expiresIn = int.tryParse(data['expires_in'].toString());
      client = ClientEntity.fromJson(data['client']);
    }
    message = json['message'];
  }
}
