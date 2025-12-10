import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/auth/register/data/register_request.dart';

class RegisterData {
  /// ** requests
  final registerReq = RegisterRequest(name: 'Test User', phone: '1234567890', password: '!Ss123456', passwordConfirmation: '!Ss123456');
  final String code = '123456';
  final String invalidCode = '123456';
  final String sessionId = '01JZ0JT3RKPBRHC1ZE1BKS74V6';
  final String notExistSessionId = '01JZ0JT3RKPBRHC1ZE1BKS74V9';
  final String newPhone = '0987654321';
  final String existPhoneNum = '0987654320';

  /// ** Json responses
  /// register
  final registerSuccessJson = {
    // Fixed typo: Sccesss -> Success
    'data': {'session_id': '01JZ0JT3RKPBRHC1ZE1BKS74V6'},
    'message': 'Registration session created successfully. Please verify your OTP.',
    'status': 'success',
  };

  final registerPhoneExistsErrorJson = {
    'message': 'This mobile number is already registered.',
    'errors': {
      'phone': ['This mobile number is already registered.'],
    },
  };

  /// verifyOTP responses
  final verifyOtpSuccessJson = {
    'data': {
      'access_token': StorageKeys.token,
      'token_type': 'bearer',
      'expires_in': 3600,
      'client': {
        'id': 3,
        'phone_number': '1234567890',
        'client_name': 'Test User',
        'country_prefix': '+20',
        'client_status_id': 1,
        'created_at': '2025-01-01T00:00:00.000000Z',
        'updated_at': '2025-01-01T00:00:00.000000Z',
        'driver': 'manual',
        'social_id': null,
      },
    },
    'message': 'OTP verified successfully',
    'status': 'success',
  };
  final verifyOtpErrorJson = {'message': 'Invalid OTP code. Please try again.', 'status': 'error'};

  /// resendOTP response
  final resendOtpSuccessJson = {'data': {}, 'message': 'OTP resent successfully', 'status': 'success'};
  final resendOtpErrorJson = {'message': 'Resend OTP failed', 'status': 'error'};

  /// editPhoneNumber response
  final editPhoneNumberSuccessJson = {
    'data': {'otp_code': '000000'},
    'message': 'Phone number updated successfully. Please verify your new OTP.',
    'status': 'success',
  };
  final editPhoneNumberSessionNotExistsErrorJson = {'message': 'Session not found', 'status': 'error'};
  final editPhoneNumberTakenErrorJson = {
    'message': 'The phone has already been taken.',
    'errors': {
      'phone': ['The phone has already been taken.'],
    },
  };

  ///
}
