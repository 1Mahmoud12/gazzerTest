import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/domain/checkout_repo.dart';

class CheckoutRepoImp extends CheckoutRepo {
  final ApiClient _apiClient;

  CheckoutRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<CheckoutDataDTO>> getCheckoutData() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.getCheckoutData),
      parser: (response) => CheckoutDataDTO.fromJson(response.data['data']),
    );
  }

  @override
  Future<Result<List<VoucherDTO>>> getVouchers() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.getVoucher),
      parser: (response) {
        final list = response.data['data'] as List<dynamic>?;
        if (list == null) return <VoucherDTO>[];
        return list.map((e) => VoucherDTO.fromJson(e as Map<String, dynamic>)).toList();
      },
    );
  }

  @override
  Future<Result<VoucherDTO>> checkVoucher(String code) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.checkVoucher,
        requestBody: {
          'code': code,
        },
      ),
      parser: (response) {
        final data = (response.data['data'] ?? {}) as Map<String, dynamic>;
        final voucher = data['voucher'] as Map<String, dynamic>? ?? {};
        return VoucherDTO.fromJson(voucher);
      },
    );
  }
}
