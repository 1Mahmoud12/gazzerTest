class ClientEntity {
  final int? id;
  final String phoneNumber;
  final String? clientName;
  final String? image;
  final String? email;
  final String? createdAt;

  /// TODO: to be replaced by clientstatus name
  final int? clientStatusId;

  final String? driver;
  final String? socialId;

  ClientEntity({
    required this.id,
    required this.phoneNumber,
    required this.clientName,
    required this.clientStatusId,
    required this.driver,
    required this.socialId,
    this.image,
    this.email,
    this.createdAt,
  });
}
