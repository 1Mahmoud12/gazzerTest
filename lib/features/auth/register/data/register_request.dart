import 'dart:io';

import 'package:gazzer/core/presentation/resources/app_const.dart';

class RegisterRequest {
  final String name;
  final String? email;
  final String phone;
  final String? fcmToken;
  final String? deviceId;
  final String countryIso;
  final String password;
  final String passwordConfirmation;
  final String? referralCode;

  RegisterRequest({
    required this.name,
    required this.phone,
    this.email,
    this.fcmToken,
    this.deviceId,
    this.countryIso = "EG",
    required this.password,
    required this.passwordConfirmation,
    this.referralCode,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      if (email != null) 'email': email,
      'country_iso': countryIso,
      'password': password,
      'password_confirmation': passwordConfirmation,
      if (referralCode != null && referralCode!.isNotEmpty)
        'referral_code': referralCode,
      if (fcmToken != null) 'fcm_token': AppConst.fcmToken,
      if (deviceId != null) 'device_id': AppConst.deviceId,
      'device_type': Platform.isAndroid ? 'android' : 'ios',
      'app_version': '1.0.0',
    };
  }

  RegisterRequest copyWith({
    String? name,
    String? phone,
    String? email,
    String? countryIso,
    String? password,
    String? passwordConfirmation,
  }) {
    return RegisterRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryIso: countryIso ?? this.countryIso,
      password: password ?? this.password,
      passwordConfirmation: passwordConfirmation ?? this.passwordConfirmation,
      fcmToken: fcmToken,
      deviceId: deviceId,
    );
  }
}
