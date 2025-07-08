import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/auth/login/data/login_repo_imp.dart';
import 'package:gazzer/features/auth/login/domain/login_repo.dart';
import 'package:mockito/mockito.dart';

import '../../test_di.dart';
import 'login_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  group('RegisterRepo Tests', () {
    final apiClient = diTest.get<ApiClient>();
    late LoginRepo registerRepo;
    final loginData = LoginData();
    final Response successResponse = Response(statusCode: 200, requestOptions: RequestOptions());
    final Response errorResponse = Response(statusCode: 422, requestOptions: RequestOptions());

    setUp(() {
      registerRepo = LoginRepoImp(apiClient);
    });

    tearDown(() {
      reset(apiClient);
    });
    group('Login Function Tests', () {
      test(
        'should return String Message when login succeeds',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.login, requestBody: loginData.validBody),
          ).thenAnswer((_) async => successResponse..data = loginData.loginSuccessJson);

          final result = await registerRepo.login(loginData.validPhone, loginData.validPassword);

          expect(result, isInstanceOf<Ok<String>>());
          expect((result as Ok<String>).value, isNotNull);
        },
      );

      test(
        'should return Error with message when login fails',
        () async {
          when(
            apiClient.post(endpoint: Endpoints.login, requestBody: loginData.invalidBody),
          ).thenAnswer((_) async => errorResponse..data = loginData.loginErrorJson);

          final result = await registerRepo.login(loginData.invalidPhone, loginData.invalidPassword);

          expect(result, isInstanceOf<Error<String>>());
          expect((result as Error<String>).error.message, isNotNull);
        },
      );
    });
  });
}
