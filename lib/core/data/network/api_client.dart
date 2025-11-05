import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  /// Singleton instance of [ApiClient].
  static final ApiClient _instance = ApiClient._();
  factory ApiClient() => _instance;

  final Dio _dio = Dio();

  /// Static for handling deep linking
  static final mainDomain = "https://tkgazzer.com";
  // static final mainDomain = "https://gazzer-test-do.mostafa.cloud/"; // test domain
  final String baseURL = "$mainDomain/api/";

  /// Headers
  final String _acceptLanguage = "Accept-Language";
  final String _authorization = "authorization";
  final timeOut = const Duration(seconds: 30);
  var cancelToken = CancelToken();

  ApiClient._() {
    _dio.options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: timeOut,
      receiveTimeout: timeOut,
      sendTimeout: timeOut,
      validateStatus: (status) => (status ?? 500) < 400,
      headers: {
        'Accept': 'application/json',
        _acceptLanguage: di<SharedPreferences>().getString(StorageKeys.locale) ?? Platform.localeName.substring(0, 2),
      },
    );

    /// Adding interceptors for logging only in debug mode
    if (kDebugMode) _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
  }

  void changeLocale(String languageCode) => _dio.options.headers[_acceptLanguage] = languageCode;

  Map<String, dynamic> _getHeaders(Map<String, dynamic>? headers) {
    final custHeaders = <String, dynamic>{};
    final String? token = TokenService.getToken();
    if (token != null) custHeaders.addAll({_authorization: "Bearer $token"});
    if (headers != null) custHeaders.addAll(headers);
    return custHeaders;
  }

  /// [queryParameters] can be used to add query parameters to the request
  ///
  /// [headers] can be used to add custom headers to the request not including the authorization header
  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(
          headers: _getHeaders(headers),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        ),
        cancelToken: cancelToken,
      );
      if (response.data['data'] == null) {
        throw Exception(response.data['message']);
      }
      return response;
    } on DioException catch (e) {
      _noInternetConnection(e.type);
      // final message = e.response?.data is Map ? (e.response?.data?['message'] ?? '') : '';
      // _unAuthenticated(message);
      rethrow;
    }
  }

  /// set [customRequestDuration] override the default request duration which [timeOut] value
  ///
  /// use [onSendProgress] to track the upload progress
  ///
  /// [requestBody] Must be a [Map] or [Null] [FormData] for file uploads
  ///
  /// [queryParameters] can be used to add query parameters to the request
  ///
  /// [headers] can be used to add custom headers to the request not including the authorization header
  Future<Response> post({
    required String endpoint,
    required var requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Duration? customRequestDuration,
    void Function(int, int)? onSendProgress,
    CancelToken? cancelToken,
  }) async {
    assert(requestBody is Map? || requestBody is FormData, 'requestBody must be a Map or FormData for file uploads');
    try {
      final response = await _dio.post(
        endpoint,
        queryParameters: queryParameters,
        data: requestBody,
        onSendProgress: onSendProgress,
        options: Options(
          receiveTimeout: customRequestDuration ?? const Duration(seconds: 30),
          sendTimeout: customRequestDuration ?? const Duration(seconds: 30),
          headers: _getHeaders(headers),
        ),
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      _noInternetConnection(e.type);
      // final message = e.response?.data is Map ? (e.response?.data?['message'] ?? '') : '';
      // _unAuthenticated(message);
      rethrow;
    }
  }

  /// [queryParameters] can be used to add query parameters to the request
  ///
  /// [headers] can be used to add custom headers to the request not including the authorization header
  Future<Response> delete({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: _getHeaders(headers)),
      );
      return response;
    } on DioException catch (e) {
      _noInternetConnection(e.type);
      // final message = e.response?.data is Map ? (e.response?.data?['message'] ?? '') : '';
      // _unAuthenticated(message);
      rethrow;
    }
  }

  bool isDisconected = false;

  /// Handles no internet connection scenarios.
  void _noInternetConnection(DioExceptionType e) {
    if (e == DioExceptionType.connectionError ||
        e == DioExceptionType.connectionTimeout ||
        e == DioExceptionType.receiveTimeout ||
        // e == DioExceptionType.cancel ||
        e == DioExceptionType.sendTimeout) {
      isDisconected = true;
      // TODO: trigger Connection bus event to show offline widget
      // ConnectionBus.inst.emitNoConnectionState();
    }
  }

  // ignore: unused_element
  void _unAuthenticated(msg) {
    if (['Unauthenticated.'].contains(msg?.toString())) {
      /// TODO: remove token and user cached data, request a refresh token
    }
  }
}
