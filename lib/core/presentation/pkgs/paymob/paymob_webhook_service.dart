import 'package:dio/dio.dart';
import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/main.dart';

class PaymobWebhookService {
  const PaymobWebhookService._();

  static Future<Map<String, dynamic>> fetchWebhookResponse(String url) async {
    try {
      final uri = Uri.parse(url);
      final endpoint = uri.path.replaceFirst('/api/', '');
      final response = await di<ApiClient>().get(
        endpoint: endpoint,
        queryParameters: uri.queryParameters,
      );
      final data = response.data;

      if (data is Map<String, dynamic> && data['status'] == 'completed') {
        return data;
      }
      return {'status': 'error', 'message': 'Invalid response'};
    } on Exception catch (e) {
      final response = e is DioException ? e.response : null;
      logger.d('badResponse ===> ${e.toString()}');

      return response?.data;
    }
  }
}
