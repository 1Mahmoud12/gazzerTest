import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/crashlytics_repo.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/di.dart';

/// any repo in the app that makes api calls should extend this class
/// it provides a [call] method that takes an api call and a parser function
/// and returns a [Result] of <[T]> type which generated from [parser] method
///  or an [ApiError] if the api call fails.
///
abstract class BaseApiRepo {
  late final CrashlyticsRepo _crashlyticsRepo;

  BaseApiRepo() {
    _crashlyticsRepo = di.get<CrashlyticsRepo>();
  }

  /// Calls the API and parses the response.
  ///
  /// Returns a [Result<T>] which is either an [Ok] of <[T]> generated from [parser] or an [ApiError].
  ///
  /// [ApiError] can be generated from either the [apiCall] or the [parser] function.
  ///
  /// The error is also sent to crashlytics for further analysis.
  Future<Result<T>> call<T>({
    required Future<Response> Function() apiCall,
    required T Function(Response response) parser,
  }) async {
    try {
      final result = await apiCall();
      return Result.ok(parser(result));
    } catch (e, stack) {
      /// Either the api call failed or the parser function threw an exception.
      return Error(_handle(e, stack));
    }
  }

  /// Handles the error, send it to crashlytics and returns an [ApiError].
  ///
  /// Error is resulted from either the [apiCall]  which is going to be a [DioException]
  /// or the [parser] function which is going to be an [Exception].
  ApiError _handle(Object error, StackTrace? stack) {
    ApiError apiError = ApiError(message: error.toString());
    try {
      if (error is! DioException) {
        /// if the error is not a DioException, it means it is an Exception
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
          apiError.message = L10n.tr().somethingWentWrong;
          break;
      }
      return apiError;
    } catch (e, stack) {
      // exception here can occurs from many reasons, like:
      // - sending [Exception] to crashlytics
      // - parsing the error response from the server with [ApiError.fromJson]
      // - giving a translated message according to locale of context (which may not be available)
      // and throws an exception
      try {
        // if the exception is due to parsin, it will succeed here
        _crashlyticsRepo.sendToCrashlytics(error, stack, reason: 'Parsing errors');
        return ApiError(message: L10n.tr().somethingWentWrong);
      } catch (e) {
        // if the exception is due to sending to crashlytics, or translation, it will fail here
        return ApiError(message: L10n.tr().somethingWentWrong);
      }
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
