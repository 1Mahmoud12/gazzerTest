import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/repos/crashlytics_repo.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

/// any repo in the app that makes api calls should extend this class
/// it provides a [call] method that takes an api call and a parser function
/// and returns a [Result] of <[T]> type which generated from [parser] method
///  or an [BadResponse] if the api call fails.
///
abstract class BaseApiRepo {
  late final CrashlyticsRepo _crashlyticsRepo;
  // TODO: dependency injection for CrashlyticsRepo should be done in the constructor
  BaseApiRepo(this._crashlyticsRepo);

  /// Calls the API and parses the response.
  ///
  /// Returns a [Result<T>] which is either an [Ok] of <[T]> generated from [parser] or an [BadResponse].
  ///
  /// [BadResponse] can be generated from either the [apiCall] or the [parser] function.
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
      return Err(isTokenExpired(e) ?? _handle(e, stack));
    }
  }

  /// Handles the error, send it to crashlytics and returns an [BaseError].
  ///
  /// Error is resulted from either the [apiCall]  which is going to be a [DioException]
  /// or the [parser] function which is going to be an [Exception].
  BaseError _handle(Object error, StackTrace? stack) {
    try {
      if (error is! DioException) {
        return _formParsingError(error, stack);
      }
      if ((error.response?.statusCode ?? 400) > 499) {
        return BaseError(
          message: L10n.tr().somethingWentWrong,
          e: ErrorType.unknownError,
        );
      }
      switch (error.type) {
        case DioExceptionType.badResponse:
          // Check for OTP rate limit error (400 with remaining_seconds)
          if (error.response?.statusCode == 400 && error.response?.data?['data']?['remaining_seconds'] != null) {
            return OtpRateLimitError.fromJson(
              error.response?.data,
              e: ErrorType.badResponse,
            );
          }
          return BadResponse.fromJson(
            error.response?.data,
            e: ErrorType.badResponse,
          );
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          return BaseError(
            message: L10n.tr().requestTimeOut,
            e: ErrorType.noInternetConnection,
          );
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
          return BaseError(
            message: L10n.tr().weakOrNoInternetConnection,
            e: ErrorType.noInternetConnection,
          );

        case DioExceptionType.cancel:
          return BaseError(
            message: L10n.tr().requestToServerWasCancelled,
            e: ErrorType.cancel,
          );

        case DioExceptionType.unknown:
          return BaseError(
            message: L10n.tr().unknownErorOccurred,
            e: ErrorType.unknownError,
          );

        default:
          return BaseError(
            message: L10n.tr().somethingWentWrong,
            e: ErrorType.unknownError,
          );
      }
    } catch (e, stack) {
      // exception here can occurs from many reasons, like:
      // - sending [Exception] to crashlytics during [_formParsingError]
      // - parsing the error response from the server with [BadResponse.fromJson]
      // - giving a translated message according to locale of context (which may not be available)
      //   and throws an exception
      try {
        // if the exception is due to parsin, it will succeed here
        _crashlyticsRepo.sendToCrashlytics(
          error,
          stack,
          reason: 'Parsing errors',
        );
        return BaseError(
          message: L10n.tr().somethingWentWrong,
          e: ErrorType.unknownError,
        );
      } catch (e) {
        // if the exception is due to sending to crashlytics, or translation, it will fail here
        return BaseError(
          message: L10n.tr().somethingWentWrong,
          e: ErrorType.unknownError,
        );
      }
    }
  }

  /// Checks if the error is a DioException with status code 498, which indicates an expired token.
  //  TODO: should implenet logic te refresh token in this case??
  BaseError? isTokenExpired(Object error) {
    if (error is DioException && error.response?.statusCode == 498) {
      return BaseError(
        message: "Token has been expired",
        e: ErrorType.expireTokenError,
      );
    }
    return null;
  }

  BaseError _formParsingError(Object error, StackTrace? stack) {
    /// if the error is not a DioException, it means it is an Exception due to parsing the response
    _crashlyticsRepo.sendToCrashlytics(error, stack, reason: 'Parsing data');
    try {
      return BaseError(
        message: L10n.tr().somethingWentWrong,
        e: ErrorType.parseError,
      );
    } catch (e) {
      return BaseError(
        message: "Something went wrong",
        e: ErrorType.parseError,
      );
    }
  }
}
