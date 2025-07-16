enum ErrorType {
  badResponse,
  noInternetConnection,
  parseError,
  expireTokenError,
  unknownError,
}

/// Base class for all error types in the application.
class BaseError {
  late String message;
  ErrorType e;
  BaseError({this.message = '', required this.e});
}

class BadResponse extends BaseError {
  late bool isSingle;
  List<String>? _errors;
  @override
  BadResponse.fromJson(Map<String, dynamic> json, {super.e = ErrorType.badResponse}) {
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
      message = (json['message'].toString().length < 60) ? json['message'] : '${json['message'].toString().substring(0, 60)}...';
    }
  }
}
