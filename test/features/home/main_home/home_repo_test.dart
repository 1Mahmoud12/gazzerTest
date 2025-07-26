import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';
import 'package:gazzer/features/home/main_home/data/home_repo_imp.dart';
import 'package:gazzer/features/home/main_home/domain/category_entity.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:mockito/mockito.dart';

import '../../../core/core_generator.mocks.dart';
import '../../../test_di.dart';
import 'home_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initTest();

  late MockApiClient apiClient;
  late HomeRepo homeRepo;
  final homeData = HomeData();
  final Response successResponse = Response(statusCode: 200, requestOptions: RequestOptions());
  final DioException errorResponse = DioException(
    requestOptions: RequestOptions(),
    type: DioExceptionType.badResponse,
    response: Response(requestOptions: RequestOptions(), statusCode: 422),
  );

  setUp(() {
    apiClient = MockApiClient();
    homeRepo = HomeRepoImp(apiClient, diTest<CrashlyticsRepo>());
  });

  tearDown(() {
    reset(apiClient);
  });
  group('Get categories Function Tests', () {
    test(
      'should return a list of categories when the request is successful',
      () async {
        when(
          apiClient.get(endpoint: Endpoints.storesCategories),
        ).thenAnswer((_) async => successResponse..data = homeData.categoriesSuccessJson);

        final result = await homeRepo.getCategories();

        expect(result, isInstanceOf<Ok<List<CategoryEntity>>>());
        expect((result as Ok<List<CategoryEntity>>).value, isNotEmpty);
      },
    );

    test(
      'should return Error with message when fetching categories fails',
      () async {
        when(
          apiClient.get(endpoint: Endpoints.storesCategories),
        ).thenThrow(() {
          errorResponse.response!.data = homeData.getGeneralErrorJson;
          return errorResponse;
        }());

        final result = await homeRepo.getCategories();

        expect(result, isInstanceOf<Err<List<CategoryEntity>>>());
        expect((result as Err<List<CategoryEntity>>).error.message, isNotNull);
        expect(result.error.message, contains('error'));
      },
    );
  });
}
