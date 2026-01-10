import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';
import 'package:gazzer/features/auth/login/data/login_repo_imp.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:mockito/mockito.dart';

import '../../../test_di.dart';
import 'login_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  group('RegisterRepo Tests', () {
    final apiClient = diTest.get<ApiClient>();
    late LoginRepo loginRepo;
    final loginData = LoginData();
    final Response successResponse = Response(statusCode: 200, requestOptions: RequestOptions());
    final DioException errorResponse = DioException(
      requestOptions: RequestOptions(),
      type: DioExceptionType.badResponse,
      response: Response(requestOptions: RequestOptions(), statusCode: 422, data: loginData.loginErrorJson),
    );

    setUp(() {
      loginRepo = LoginRepoImp(apiClient, diTest<CrashlyticsRepo>());
    });

    tearDown(() {
      reset(apiClient);
    });
    group('Login Function Tests', () {
      test('should return String Message when login succeeds', () async {
        when(
          apiClient.post(endpoint: Endpoints.login, requestBody: loginData.validBody),
        ).thenAnswer((_) async => successResponse..data = loginData.loginSuccessJson);

        final result = await loginRepo.login(loginData.validPhone, loginData.validPassword);

        expect(result, isInstanceOf<Ok<String>>());
        expect((result as Ok<String>).value, isNotNull);
      });

      test('should return Error with message when login fails', () async {
        when(
          apiClient.post(endpoint: Endpoints.login, requestBody: {'phone': loginData.invalidPhone, 'password': loginData.invalidPassword}),
        ).thenThrow(errorResponse);

        final result = await loginRepo.login(loginData.invalidPhone, loginData.invalidPassword);

        expect(result, isInstanceOf<Err<String>>());
        expect((result as Err<String>).error.message, isNotNull);
        expect(result.error.message, contains('match'));
      });
    });
  });
}
