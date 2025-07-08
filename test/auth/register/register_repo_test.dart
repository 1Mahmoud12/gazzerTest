import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/register/data/register_repo_imp.dart';
import 'package:mockito/mockito.dart';

import '../../core/core_generator.mocks.dart';
import '../../test_di.dart';
import 'register_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  group('RegisterRepo Tests', () {
    late MockApiClient apiClient;
    late RegisterRepoImp registerRepo;
    final registerData = RegisterData();
    final Response successResponse = Response(statusCode: 200, requestOptions: RequestOptions());
    final Response errorResponse = Response(statusCode: 422, requestOptions: RequestOptions());

    setUp(() {
      apiClient = MockApiClient();
      registerRepo = RegisterRepoImp(apiClient);
    });

    tearDown(() {
      reset(apiClient);
    });
    group('Register Function Tests', () {
      test(
        'should return AuthResponse with sessionId and message when registration succeeds',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.register, requestBody: registerData.registerReq.toJson()),
          ).thenAnswer((_) async => successResponse..data = registerData.registerSuccessJson);

          final result = await registerRepo.register(registerData.registerReq);

          expect(result, isInstanceOf<Ok<AuthResponse>>());
          expect((result as Ok<AuthResponse>).value.msg, isNotNull);
          expect((result).value.sessionId, equals(registerData.sessionId));
        },
      );

      test(
        'should return Error with message when registration fails',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.register, requestBody: registerData.registerReq.toJson()),
          ).thenAnswer((_) async => errorResponse..data = registerData.registerErrorJson);

          final result = await registerRepo.register(registerData.registerReq);

          expect(result, isInstanceOf<Error<AuthResponse>>());
          expect((result as Error<AuthResponse>).error.message, isNotNull);
        },
      );
    });

    group('ResendOTP Function Tests', () {
      test(
        'should return success message when resend OTP succeeds',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.resendOtp(registerData.sessionId), requestBody: {}),
          ).thenAnswer((_) async => successResponse..data = registerData.resendOtpSuccessJson);

          final result = await registerRepo.resendOtp(registerData.sessionId);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
        },
      );
    });

    group('EditPhoneNumber Function Tests', () {
      test(
        'should return success message when phone number edit succeeds',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.editPhoneNum(registerData.sessionId),
              requestBody: {'phone': registerData.newPhone},
            ),
          ).thenAnswer(
            (_) async => successResponse..data = registerData.editPhoneNumberSuccessJson,
          );

          final result = await registerRepo.editPhoneNumber(registerData.sessionId, registerData.newPhone);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
        },
      );
      test(
        'should return Error when phone number edit fails due to session not existing',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.editPhoneNum(registerData.notExistSessionId),
              requestBody: {'phone': registerData.newPhone},
            ),
          ).thenAnswer(
            (_) async => errorResponse..data = registerData.editPhoneNumberSessionNotExistsErrorJson,
          );

          final result = await registerRepo.editPhoneNumber(registerData.sessionId, registerData.newPhone);

          expect(result, isInstanceOf<Error<String>>());
          expect((result as Error<String>).error.message, isNotNull);
        },
      );
      test(
        'should return Error when phone number edit fails due to phone already taken',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.editPhoneNum(registerData.sessionId),
              requestBody: {'phone': registerData.existPhoneNum},
            ),
          ).thenAnswer(
            (_) async => errorResponse..data = registerData.editPhoneNumberTakenErrorJson,
          );

          final result = await registerRepo.editPhoneNumber(registerData.sessionId, registerData.newPhone);

          expect(result, isInstanceOf<Error<String>>());
          expect((result as Error<String>).error.message, isNotNull);
        },
      );
    });

    group('VerifyOTP Function Tests', () {
      test(
        'should return success message when OTP verification succeeds',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.verifyOTP,
              requestBody: {'session_id': registerData.sessionId, 'otp_code': registerData.code},
            ),
          ).thenAnswer((_) async => successResponse..data = registerData.verifyOtpSuccessJson);

          final result = await registerRepo.verifyOTP(registerData.sessionId, registerData.code);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
        },
      );

      test(
        'should return Error when OTP verification fails',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.verifyOTP,
              requestBody: {'session_id': registerData.sessionId, 'otp_code': registerData.code},
            ),
          ).thenAnswer((_) async => errorResponse..data = registerData.verifyOtpErrorJson);

          final result = await registerRepo.verifyOTP(registerData.sessionId, registerData.code);

          expect(result, isInstanceOf<Error<String>>());
          expect((result as Error<String>).error.message, isNotNull);
        },
      );
    });
  });
}
