import 'package:dio/dio.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

/// Base class for all error types in the application.
abstract class BaseError {
  late String message;
  BaseError({this.message = ''});
}

class ApiError extends BaseError {
  late bool isSingle;
  List<String>? _errors;
  DioExceptionType? e;

  ApiError({required super.message, this.isSingle = true, this.e});

  ApiError.fromJson(Map<String, dynamic> json, {this.e}) {
    if (json['errors'] is Map) {
      final errors = json['errors'] as Map<String, dynamic>;
      final List<String> errosList = [];
      for (var e in errors.values) {
        if (e is List<dynamic>) {
          errosList.addAll(e.map((e) => e));
        }
      }
      _errors = errosList;
    } else if (json['errors'] is List<dynamic>) {
      for (var e in json['errors']) {
        _errors ??= [];
        _errors?.add(e);
      }
    }
    if (_errors?.isNotEmpty == true) {
      isSingle = false;
      message = _errors!.join(", ");
    } else {
      isSingle = true;
      message = json['message'] ?? L10n.tr().somethingWentWrong;
    }
  }
}
