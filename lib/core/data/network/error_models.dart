import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';

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
