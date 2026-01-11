import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/routing/app_navigator.dart';
import 'package:intl/intl.dart';

class ReferralEntity {
  final String? code;
  final String? shareLink;
  final String? shareMessage;

  ReferralEntity({this.code, this.shareLink, this.shareMessage});
}

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
  final String? tierName;
  final ReferralEntity? referral;

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
    this.tierName,
    this.referral,
  });


factory ClientEntity.domy() {
    return  ClientEntity(
    id: 1,
    phoneNumber: '+201012345678',
    clientName: 'Ahmed Hassan',
    clientStatusId: 1,
    driver: 'Uber',
    socialId: 'ahmed_hassan_92',
    email: 'ahmed.hassan@gmail.com',
    image: 'https://i.pravatar.cc/150?img=4',
    createdAt: '2023-01-15T10:30:00Z',
    tierName: 'hero',
   
  );
  }
  String get formatedCreatedAt {
    if (createdAt == null) return L10n.tr().notSetYet;
    final date = DateTime.parse(createdAt!);
    final formateddate = DateFormat(
      'MMMM, yyyy',
      L10n.isAr(AppNavigator.mainKey.currentContext!) ? 'ar' : 'en',
    ).format(date);
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
      tierName: tierName,
      referral: referral,
    );
  }
}
