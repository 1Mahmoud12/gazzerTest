import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:intl/intl.dart';

class ClientEntity {
  final int id;
  final String phoneNumber;
  final String clientName;
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

  String get formatedCreatedAt {
    if (createdAt == null) return L10n.tr().notSetYet;
    final date = DateTime.parse(createdAt!);
    final formateddate = DateFormat('MMMM, yyyy').format(date);
    return formateddate;
  }

  ClientEntity clone() {
    return ClientEntity(
      id: id,
      phoneNumber: phoneNumber,
      clientName: clientName,
      image: image,
      email: email,
      createdAt: createdAt,
      clientStatusId: clientStatusId,
      driver: driver,
      socialId: socialId,
    );
  }
}
