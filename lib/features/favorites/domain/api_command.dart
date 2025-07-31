import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/error_models.dart';
import 'package:gazzer/core/data/network/result_model.dart';

class ApiCommand<T> {
  ApiCommand({
    required this.action,
    required this.onError,
    required this.onSuccess,
    required this.unDo,
  });
  final CancelToken _cancelToken = CancelToken();
  bool _running = false;
  bool get running => _running;

  BaseError? _error;
  BaseError? get error => _error;

  bool _completed = false;
  bool get completed => _completed;

  bool _canceled = false;
  bool get canceled => _canceled;

  final Future<Result<T>> Function(CancelToken) action;
  final Future<void> Function() unDo;
  final void Function(Err<T> error) onError;
  final void Function(Ok<T> result) onSuccess;

  Future<void> execute() async {
    if (_running) return;
    _running = true;
    _completed = false;
    _error = null;
    try {
      final result = await action(_cancelToken);
      if (_canceled) return;
      switch (result) {
        case Ok<T> ok:
          _completed = true;
          if (!_canceled) onSuccess(ok);
          break;
        case Err<T> err:
          _error = err.error;
          if (!_canceled) onError(err);
          break;
      }
      _completed = true;
    } catch (e) {
      _error = BaseError(e: ErrorType.unknownError, message: e.toString());
      onError(Err<T>(_error!));
    } finally {
      _running = false;
    }
  }

  void cancel() {
    _canceled = true;
    if (_cancelToken.isCancelled) return;
    _cancelToken.cancel();
    clear();
  }

  void clear() {
    _running = false;
    _error = null;
    _completed = false;
  }
}
