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

class ReferralDTO {
  String? code;
  String? shareLink;
  String? shareMessage;

  ReferralDTO({this.code, this.shareLink, this.shareMessage});

  ReferralDTO.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    shareLink = json['share_link'];
    shareMessage = json['share_message'];
  }

  ReferralEntity toReferralEntity() {
    return ReferralEntity(code: code, shareLink: shareLink, shareMessage: shareMessage);
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
  String? tierName;
  String? image;
  ReferralDTO? referral;

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
    this.tierName,
    this.referral,
    this.image,
  });

  ClientDTO.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    clientName = json['client_name'];
    countryPrefix = json['country_prefix'];
    clientStatusId = json['client_status_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['avatar'];
    driver = json['driver'];
    socialId = json['social_id'];
    email = json['email'];
    tierName = json['loyalty_tier_name'];
    referral = json['referral'] != null ? ReferralDTO.fromJson(json['referral']) : null;
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
      image: image,
      email: email,
      tierName: tierName,
      referral: referral?.toReferralEntity(),
    );
  }
}
