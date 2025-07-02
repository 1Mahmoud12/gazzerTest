import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';

class ClientResponse {
  String? message;
  late final ClientEntity client;

  late final String accessToken;
  int? expiresIn;
  // String? tokenType;

  ClientResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      accessToken = json['access_token'];
      // tokenType = json['token_type'];
      expiresIn = int.tryParse(json['expires_in'].toString());
      client = ClientEntity.fromJson(json['client']);
    }
    message = json['message'];
  }
}
