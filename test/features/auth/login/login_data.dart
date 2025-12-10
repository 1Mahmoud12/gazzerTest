import 'package:gazzer/core/data/local_storage/local_storage.dart';

class LoginData {
  final validPhone = '1234567890';
  final validPassword = 'Password!123';
  Map<String, dynamic> get validBody => {'phone': validPhone, 'password': validPassword};

  Map<String, dynamic> get invalidBody => {'phone': invalidPhone, 'password': invalidPassword};
  final invalidPhone = '1234567899';
  final invalidPassword = 'pass';

  /// response json for login request
  final loginSuccessJson = {
    'data': {
      'access_token': StorageKeys.token,
      'token_type': 'bearer',
      'expires_in': 1,
      'client': {
        'id': 2,
        'phone_number': '1234567899',
        'client_name': 'test-asd',
        'country_prefix': '+20',
        'client_status_id': 1,
        'created_at': '2025-07-06T10:48:14.000000Z',
        'updated_at': '2025-07-06T10:48:14.000000Z',
        'driver': 'manual',
        'social_id': null,
      },
    },
    'message': 'Client logged in successfully',
    'status': 'success',
  };
  final loginErrorJson = {'message': 'Credentials does not match', 'status': 'error'};
}
