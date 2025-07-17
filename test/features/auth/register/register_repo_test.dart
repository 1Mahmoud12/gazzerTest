import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/crashlytics_repo.dart';
import 'package:gazzer/features/auth/common/data/auth_response.dart';
import 'package:gazzer/features/auth/register/data/register_repo_imp.dart';
import 'package:mockito/mockito.dart';

import '../../../core/core_generator.mocks.dart';
import '../../../test_di.dart';
import 'register_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  group('RegisterRepo Tests', () {
    late MockApiClient apiClient;
    late RegisterRepoImp registerRepo;
    final registerData = RegisterData();
    final Response successResponse = Response(statusCode: 200, requestOptions: RequestOptions());
    final DioException errorResponse = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.badResponse,
      response: Response(requestOptions: RequestOptions(), statusCode: 422),
    );

    setUp(() {
      apiClient = MockApiClient();
      registerRepo = RegisterRepoImp(apiClient, diTest<CrashlyticsRepo>());
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
          ).thenThrow(() {
            errorResponse.response!.data = registerData.registerPhoneExistsErrorJson;
            return errorResponse;
          }());

          final result = await registerRepo.register(registerData.registerReq);

          expect(result, isInstanceOf<Err<AuthResponse>>());
          expect((result as Err<AuthResponse>).error.message, isNotNull);
          expect(result.error.message, contains('mobile'));
        },
      );
    });

    group('ResendOTP Function Tests', () {
      test(
        'should return success message when resend OTP succeeds',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.resendOtp,
              requestBody: {'session_id': registerData.sessionId},
            ),
          ).thenAnswer((_) async => successResponse..data = registerData.resendOtpSuccessJson);

          final result = await registerRepo.resendOtp(registerData.sessionId);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
        },
      );
      test(
        'should return error message when resend OTP fails',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.resendOtp, requestBody: {'session_id': registerData.sessionId}),
          ).thenThrow(() {
            errorResponse.response!.data = registerData.resendOtpErrorJson;
            return errorResponse;
          }());

          final result = await registerRepo.resendOtp(registerData.sessionId);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
          expect(result.error.message, contains('Resend OTP failed'));
        },
      );
    });

    group('EditPhoneNumber Function Tests', () {
      test(
        'should return success message when phone number edit succeeds',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.editPhoneNum,
              requestBody: {'phone': registerData.newPhone, 'session_id': registerData.sessionId},
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
              endpoint: Endpoints.editPhoneNum,
              requestBody: {'phone': registerData.newPhone, 'session_id': registerData.notExistSessionId},
            ),
          ).thenThrow(() {
            errorResponse.response!.data = registerData.editPhoneNumberSessionNotExistsErrorJson;
            return errorResponse;
          }());

          final result = await registerRepo.editPhoneNumber(registerData.notExistSessionId, registerData.newPhone);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
          expect(result.error.message, contains('Session'));
        },
      );
      test(
        'should return Error when phone number edit fails due to phone already taken',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.editPhoneNum,
              requestBody: {'phone': registerData.existPhoneNum, 'session_id': registerData.sessionId},
            ),
          ).thenThrow(() {
            errorResponse.response!.data = registerData.editPhoneNumberTakenErrorJson;
            return errorResponse;
          }());

          final result = await registerRepo.editPhoneNumber(registerData.sessionId, registerData.newPhone);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
          expect(result.error.message, contains('phone'));
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
          ).thenThrow(() {
            errorResponse.response!.data = registerData.verifyOtpErrorJson;
            return errorResponse;
          }());

          final result = await registerRepo.verifyOTP(registerData.sessionId, registerData.code);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
          expect(result.error.message, contains('Invalid'));
        },
      );
    });

    group('Verify Repo Function Tests', () {
      group('Verify Function Tests', () {
        test(
          'should return success message when OTP verification succeeds',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.verifyOTP,
                requestBody: {'session_id': registerData.sessionId, 'otp_code': registerData.code},
              ),
            ).thenAnswer((_) async => successResponse..data = registerData.verifyOtpSuccessJson);

            final result = await registerRepo.verify(registerData.code, registerData.sessionId);

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
                requestBody: {'session_id': registerData.sessionId, 'otp_code': registerData.invalidCode},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = registerData.verifyOtpErrorJson;
              return errorResponse;
            }());

            final result = await registerRepo.verify(registerData.invalidCode, registerData.sessionId);

            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
            expect(result.error.message, contains('Invalid'));
          },
        );
      });
      group('Resend Function Tests', () {
        test(
          'should return success message when resend OTP succeeds',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.resendOtp,
                requestBody: {
                  'session_id': registerData.sessionId,
                },
              ),
            ).thenAnswer((_) async => successResponse..data = registerData.resendOtpSuccessJson);

            final result = await registerRepo.resend(registerData.sessionId);

            expect(result, isInstanceOf<Ok<String>>());
            expect((result as Ok<String>).value, isNotNull);
          },
        );

        test(
          'should return error message when resend OTP fails',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.resendOtp,
                requestBody: {
                  'session_id': registerData.sessionId,
                },
              ),
            ).thenThrow(() {
              errorResponse.response!.data = registerData.resendOtpErrorJson;
              return errorResponse;
            }());

            final result = await registerRepo.resend(registerData.sessionId);

            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
            expect(result.error.message, contains('Resend OTP failed'));
          },
        );
      });
      group('ChangePhone Function Tests', () {
        test(
          'should return success message when phone number edit succeeds',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.editPhoneNum,
                requestBody: {
                  'phone': registerData.newPhone,
                  'session_id': registerData.sessionId,
                },
              ),
            ).thenAnswer(
              (_) async => successResponse..data = registerData.editPhoneNumberSuccessJson,
            );

            final result = await registerRepo.onChangePhone(registerData.newPhone, registerData.sessionId);

            expect(result, isInstanceOf<Ok<String>>());
            expect((result as Ok<String>).value, isNotNull);
          },
        );
        test(
          'should return Error when phone number edit fails due to session not existing',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.editPhoneNum,
                requestBody: {'phone': registerData.newPhone, 'session_id': registerData.notExistSessionId},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = registerData.editPhoneNumberSessionNotExistsErrorJson;
              return errorResponse;
            }());

            final result = await registerRepo.onChangePhone(registerData.newPhone, registerData.notExistSessionId);

            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
            expect(result.error.message, contains('Session'));
          },
        );
        test(
          'should return Error when phone number edit fails due to phone already taken',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.editPhoneNum,
                requestBody: {'phone': registerData.existPhoneNum, 'session_id': registerData.sessionId},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = registerData.editPhoneNumberTakenErrorJson;
              return errorResponse;
            }());

            final result = await registerRepo.onChangePhone(registerData.newPhone, registerData.sessionId);

            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
            expect(result.error.message, contains('phone'));
          },
        );
      });
    });
  });
}
