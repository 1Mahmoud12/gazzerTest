import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/crashlytics_repo.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/di.dart';

abstract class BaseApiRepo {
  late final CrashlyticsRepo _crashlyticsRepo;

  BaseApiRepo() {
    _crashlyticsRepo = di.get<CrashlyticsRepo>();
  }

  Future<Result<T>> call<T>({
    required Future<Response> Function() apiCall,
    required T Function(Response response) parser,
  }) async {
    try {
      final result = await apiCall();
      return Result.ok(parser(result));
    } catch (e, stack) {
      return Error(_handle(e, stack));
    }
  }

  ApiError _handle(Object error, StackTrace? stack) {
    try {
      var apiError = ApiError(message: L10n.tr().somethingWentWrong);
      if (error is! DioException) {
        _crashlyticsRepo.sendToCrashlytics(error, stack, reason: 'Parsing data');
        return apiError;
      }
      apiError.e = error.type;
      switch (error.type) {
        case DioExceptionType.badResponse:
          apiError = ApiError.fromJson(error.response?.data, e: error.type);
          apiError.message ??= L10n.tr().somethingWentWrong;
          return apiError;
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          apiError.message = L10n.tr().requestTimeOut;
          break;
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
          apiError.message = L10n.tr().weakOrNoInternetConnection;
          break;
        case DioExceptionType.cancel:
          apiError.message = L10n.tr().requestToServerWasCancelled;
          break;
        case DioExceptionType.unknown:
          apiError.message = L10n.tr().unknownErorOccurred;
          break;
        default:
      }
      return apiError;
    } catch (e, stack) {
      // sent to crashlytics
      _crashlyticsRepo.sendToCrashlytics(error, stack, reason: 'Parsing errors');
      return ApiError(message: "Something went wrong");
    }
  }

  // Result<T> parse<T>(T Function() parser) {
  //   try {
  //     return Result.ok(parser());
  //   } catch (e) {
  //     return Error(_handle(e));
  //   }
  // }
}
