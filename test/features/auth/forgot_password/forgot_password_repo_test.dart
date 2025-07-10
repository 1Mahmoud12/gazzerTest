import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/forgot_password/data/forgot_password_imp.dart';
import 'package:mockito/mockito.dart';

import '../../../test_di.dart';
import 'forgot_password_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  group('ForgotPasswordRepo Tests', () {
    final apiClient = diTest<ApiClient>();
    late ForgotPasswordImp forgotPasswordRepo;
    final forgetPasswordData = ForgetPasswordData();
    final Response successResponse = Response(statusCode: 200, requestOptions: RequestOptions());
    final DioException errorResponse = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.badResponse,
      response: Response(requestOptions: RequestOptions(), statusCode: 422),
    );

    setUp(() {
      forgotPasswordRepo = ForgotPasswordImp(apiClient);
    });

    tearDown(() {
      reset(apiClient);
    });

    group('ForgotPassword Function Tests', () {
      test(
        'should return success message when forgot password request succeeds',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.forgetPassword, requestBody: {"phone": forgetPasswordData.phone}),
          ).thenAnswer((_) async => successResponse..data = forgetPasswordData.forgotPasswordSuccessJson);

          final result = await forgotPasswordRepo.forgotPassword(forgetPasswordData.phone);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
        },
      );

      test(
        'should return Error with message when phone number is not registered',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.forgetPassword, requestBody: {"phone": forgetPasswordData.invalidPhone}),
          ).thenThrow(() {
            errorResponse.response!.data = forgetPasswordData.forgetPasswordErrorJson;
            return errorResponse;
          }());

          final result = await forgotPasswordRepo.forgotPassword(forgetPasswordData.invalidPhone);
          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
        },
      );
    });

    group('VerifyOtp Function Tests', () {
      test(
        'should return success message with reset token when OTP verification succeeds',
        () async {
          // First set the reset token
          forgotPasswordRepo.resetPasswordToken = forgetPasswordData.resetToken;
          when(
            apiClient.post(
              endpoint: Endpoints.forgetPasswordVerifyOTP,
              requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.validOtp},
            ),
          ).thenAnswer((_) async => successResponse..data = forgetPasswordData.verifyOtpSuccessJson);

          final result = await forgotPasswordRepo.verifyOtp(forgetPasswordData.phone, forgetPasswordData.validOtp);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
          expect(result.value, contains('verified'));
          // Check that reset token is stored internally
          expect(forgotPasswordRepo.resetPasswordToken, equals(forgetPasswordData.resetToken));
        },
      );

      test(
        'should return Error when OTP verification fails with invalid OTP',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.forgetPasswordVerifyOTP,
              requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.invalidOtp},
            ),
          ).thenThrow(() {
            errorResponse.response!.data = forgetPasswordData.verifyOtpErrorJson;
            return errorResponse;
          }());

          final result = await forgotPasswordRepo.verifyOtp(forgetPasswordData.phone, forgetPasswordData.invalidOtp);

          expect(result, isInstanceOf<Err<String>>());
          final errorResult = result as Err<String>;
          expect(errorResult.error.message, isNotNull);
          expect(errorResult.error.message, isNotEmpty);
        },
      );

      test(
        'should return Error when OTP verification fails due to expired OTP',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.forgetPasswordVerifyOTP,
              requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.expiredOtp},
            ),
          ).thenThrow(() {
            errorResponse.response!.data = forgetPasswordData.expiredOtpErrorJson;
            return errorResponse;
          }());

          final result = await forgotPasswordRepo.verifyOtp(forgetPasswordData.phone, forgetPasswordData.expiredOtp);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
        },
      );
      test(
        'should return Error when OTP verification fails due to max attempts reached',
        () async {
          when(
            apiClient.post(
              endpoint: Endpoints.forgetPasswordVerifyOTP,
              requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.maxAttempteddOtp},
            ),
          ).thenThrow(() {
            errorResponse.response!.data = forgetPasswordData.maxAttemptsReachedErrorJson;
            return errorResponse;
          }());

          final result = await forgotPasswordRepo.verifyOtp(
            forgetPasswordData.phone,
            forgetPasswordData.maxAttempteddOtp,
          );

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
        },
      );
    });

    group('ResetPassword Function Tests', () {
      test(
        'should return success message when password reset succeeds',
        () async {
          forgotPasswordRepo.resetPasswordToken = forgetPasswordData.resetToken;
          when(
            apiClient.post(
              endpoint: Endpoints.resetPassword,
              requestBody: {
                "password_confirmation": forgetPasswordData.newPassword,
                "password": forgetPasswordData.newPassword,
                "reset_password_token": forgotPasswordRepo.resetPasswordToken,
              },
            ),
          ).thenAnswer((_) async => successResponse..data = forgetPasswordData.resetPasswordSuccessJson);

          final result = await forgotPasswordRepo.resetPassword(forgetPasswordData.newPassword);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
          expect((result).value, contains('reset'));
        },
      );

      test(
        'should return Error when password reset fails with weak password',
        () async {
          forgotPasswordRepo.resetPasswordToken = forgetPasswordData.resetToken;
          when(
            apiClient.post(
              endpoint: Endpoints.resetPassword,
              requestBody: {
                "password_confirmation": forgetPasswordData.weakPassword,
                "password": forgetPasswordData.weakPassword,
                "reset_password_token": forgotPasswordRepo.resetPasswordToken,
              },
            ),
          ).thenThrow(() {
            errorResponse.response!.data = forgetPasswordData.weakPasswordErrorJson;
            return errorResponse;
          }());

          final result = await forgotPasswordRepo.resetPassword(forgetPasswordData.weakPassword);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
        },
      );

      test(
        'should return Error when password reset fails with expired token',
        () async {
          // Set an expired reset token
          forgotPasswordRepo.resetPasswordToken = forgetPasswordData.expiredResetToken;

          when(
            apiClient.post(
              endpoint: Endpoints.resetPassword,
              requestBody: {
                "password_confirmation": forgetPasswordData.newPassword,
                "password": forgetPasswordData.newPassword,
                "reset_password_token": forgetPasswordData.expiredResetToken,
              },
            ),
          ).thenThrow(() {
            errorResponse.response!.data = forgetPasswordData.expiredTokenErrorJson;
            return errorResponse;
          }());

          final result = await forgotPasswordRepo.resetPassword(forgetPasswordData.newPassword);

          expect(result, isInstanceOf<Err<String>>());
          expect((result as Err<String>).error.message, isNotNull);
        },
      );
    });

    ///
    ///
    ///

    group('Verify Repo Function Tests', () {
      group('Verify Function Tests', () {
        test(
          'should return success message with reset token when OTP verification succeeds',
          () async {
            // First set the reset token
            forgotPasswordRepo.resetPasswordToken = forgetPasswordData.resetToken;
            when(
              apiClient.post(
                endpoint: Endpoints.forgetPasswordVerifyOTP,
                requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.validOtp},
              ),
            ).thenAnswer((_) async => successResponse..data = forgetPasswordData.verifyOtpSuccessJson);

            final result = await forgotPasswordRepo.verify(forgetPasswordData.validOtp, forgetPasswordData.phone);

            expect(result, isInstanceOf<Ok<String>>());
            expect((result as Ok<String>).value, isNotNull);
            expect(result.value, contains('verified'));
            // Check that reset token is stored internally
            expect(forgotPasswordRepo.resetPasswordToken, equals(forgetPasswordData.resetToken));
          },
        );

        test(
          'should return Error when OTP verification fails with invalid OTP',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.forgetPasswordVerifyOTP,
                requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.invalidOtp},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = forgetPasswordData.verifyOtpErrorJson;
              return errorResponse;
            }());

            final result = await forgotPasswordRepo.verify(forgetPasswordData.invalidOtp, forgetPasswordData.phone);

            expect(result, isInstanceOf<Err<String>>());
            final errorResult = result as Err<String>;
            expect(errorResult.error.message, isNotNull);
            expect(errorResult.error.message, isNotEmpty);
          },
        );

        test(
          'should return Error when OTP verification fails due to expired OTP',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.forgetPasswordVerifyOTP,
                requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.expiredOtp},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = forgetPasswordData.expiredOtpErrorJson;
              return errorResponse;
            }());

            final result = await forgotPasswordRepo.verify(forgetPasswordData.phone, forgetPasswordData.expiredOtp);

            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
          },
        );
        test(
          'should return Error when OTP verification fails due to max attempts reached',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.forgetPasswordVerifyOTP,
                requestBody: {"phone": forgetPasswordData.phone, "otp_code": forgetPasswordData.maxAttempteddOtp},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = forgetPasswordData.maxAttemptsReachedErrorJson;
              return errorResponse;
            }());

            final result = await forgotPasswordRepo.verify(
              forgetPasswordData.maxAttempteddOtp,
              forgetPasswordData.phone,
            );

            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
          },
        );
      });
      group('Resend Function Tests', () {
        test(
          'should return success message when forgot password request succeeds',
          () async {
            when(
              apiClient.post(endpoint: Endpoints.forgetPassword, requestBody: {"phone": forgetPasswordData.phone}),
            ).thenAnswer((_) async => successResponse..data = forgetPasswordData.forgotPasswordSuccessJson);

            final result = await forgotPasswordRepo.resend(forgetPasswordData.phone);

            expect(result, isInstanceOf<Ok<String>>());
            expect((result as Ok<String>).value, isNotNull);
          },
        );

        test(
          'should return Error with message when phone number is not registered',
          () async {
            when(
              apiClient.post(
                endpoint: Endpoints.forgetPassword,
                requestBody: {"phone": forgetPasswordData.invalidPhone},
              ),
            ).thenThrow(() {
              errorResponse.response!.data = forgetPasswordData.forgetPasswordErrorJson;
              return errorResponse;
            }());

            final result = await forgotPasswordRepo.resend(forgetPasswordData.invalidPhone);
            expect(result, isInstanceOf<Err<String>>());
            expect((result as Err<String>).error.message, isNotNull);
          },
        );
      });
      group('ChangePhone Function Tests', () {
        test(
          'should throw UnimplementedError when trying to change phone',
          () async {
            expect(
              () => forgotPasswordRepo.onChangePhone(forgetPasswordData.newPhone, ''),
              throwsA(isA<UnimplementedError>()),
            );
          },
        );
      });
    });
  });
}
