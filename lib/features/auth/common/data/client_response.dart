import 'package:gazzer/features/auth/common/domain/entities/client_entity.dart';

class ClientResponse {
  String? message;
  late final ClientDTO client;

  late final String accessToken;
  int? expiresIn;

  ClientResponse.fromWholeResponse(Map<String, dynamic> json) {
    if (json['data'] != null) {
      final data = json['data'];
      accessToken = data['access_token'];
      expiresIn = int.tryParse(data['expires_in'].toString());
      client = ClientDTO.fromJson(data['client']);
    }
    message = json['message'];
  }
  ClientEntity toClientEntity() {
    return client.toClientEntity();
  }
}

class ClientDTO {
  int? id;
  String? phoneNumber;
  String? clientName;
  String? email;
  String? countryPrefix;
  int? clientStatusId;
  String? createdAt;
  String? updatedAt;
  String? driver;
  String? socialId;

  ClientDTO({
    this.id,
    this.phoneNumber,
    this.clientName,
    this.email,
    this.countryPrefix,
    this.clientStatusId,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.socialId,
  });

  ClientDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    clientName = json['client_name'];
    countryPrefix = json['country_prefix'];
    clientStatusId = json['client_status_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driver = json['driver'];
    socialId = json['social_id'];
    email = json['email'];
  }

  ClientEntity toClientEntity() {
    return ClientEntity(
      id: id!,
      phoneNumber: phoneNumber!,
      clientName: clientName!,
      clientStatusId: clientStatusId,
      driver: driver,
      socialId: socialId,
      createdAt: createdAt,
      email: email,
    );
  }
}
