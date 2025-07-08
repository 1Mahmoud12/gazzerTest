import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension ResposnseSuccess on Response {
  bool get isSuccess => (statusCode ?? 500) < 400;
}

class ApiClient {
  static final ApiClient _instance = ApiClient._();
  factory ApiClient() => _instance;
  final Dio _dio = Dio();
  static final mainDomain = "https://gazzer-dev-do.mostafa.cloud";
  final String baseURL = "$mainDomain/api/clients/";
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
    if (kDebugMode) {
      _dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));
    }
  }

  bool isDisconected = false;
  Future<Response> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final String? token = TokenService.getToken();
      final custHeaders = <String, dynamic>{};
      if (token != null) custHeaders.addAll({_authorization: "Bearer $token"});
      if (headers != null) custHeaders.addAll(headers);
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: custHeaders),
      );
      return response;
    } on DioException catch (e) {
      _noInternetConnection(e.type);
      // final message = e.response?.data is Map ? (e.response?.data?['message'] ?? '') : '';
      // _unAuthenticated(message);
      rethrow;
    }
  }

  Future<Response> post({
    required String endpoint,
    required var requestBody,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    Duration? customRequestDuration,
    void Function(int, int)? onSendProgress,
  }) async {
    try {
      final String? token = TokenService.getToken();
      final custHeaders = <String, dynamic>{_authorization: token != null ? "Bearer $token" : ''};
      if (headers != null) custHeaders.addAll(headers);
      final response = await _dio.post(
        endpoint,
        queryParameters: queryParameters,
        data: requestBody,
        onSendProgress: onSendProgress,
        options: Options(
          receiveTimeout: customRequestDuration,
          sendTimeout: customRequestDuration,
          headers: custHeaders,
        ),
      );
      return response;
    } on DioException catch (e) {
      _noInternetConnection(e.type);
      // final message = e.response?.data is Map ? (e.response?.data?['message'] ?? '') : '';
      // _unAuthenticated(message);
      rethrow;
    }
  }

  void changeLocale(String languageCode) => _dio.options.headers[_acceptLanguage] = languageCode;

  void _noInternetConnection(DioExceptionType e) {
    if (e == DioExceptionType.connectionError ||
        e == DioExceptionType.connectionTimeout ||
        e == DioExceptionType.receiveTimeout ||
        // e == DioExceptionType.cancel ||
        e == DioExceptionType.sendTimeout) {
      isDisconected = true;
      // TODO show offline widget
      // ConnectionBus.inst.emitNoConnectionState();
    }
  }

  void _unAuthenticated(msg) {
    if (['Unauthenticated.'].contains(msg?.toString())) {
      // Helpers.deleteUserLocally();
    }
  }
}
