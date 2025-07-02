class ClientEntity {
  int? id;
  String? phoneNumber;
  String? clientName;
  String? countryPrefix;
  int? clientStatusId;
  String? createdAt;
  String? updatedAt;
  String? driver;
  String? socialId;

  ClientEntity({
    this.id,
    this.phoneNumber,
    this.clientName,
    this.countryPrefix,
    this.clientStatusId,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.socialId,
  });

  ClientEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
    clientName = json['client_name'];
    countryPrefix = json['country_prefix'];
    clientStatusId = json['client_status_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driver = json['driver'];
    socialId = json['social_id'];
  }
}
