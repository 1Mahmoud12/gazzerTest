import 'package:dio/dio.dart';

extension CancelTokenExtension on CancelToken {
  CancelToken regenerate() {
    if (!isCancelled) cancel();

    return CancelToken();
  }
}
