import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_params.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_response_dto.dart';
import 'package:gazzer/features/checkout/data/dtos/order_summary_dto.dart';
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
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.getVoucher,
        headers: const {
          'Accept-Language': 'en', // Force English until backend supports AR properly
        },
      ),
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

  @override
  Future<Result<String>> addCard({
    required String cardNumber,
    required String cardholderName,
    required String expiryMonth,
    required String expiryYear,
    required bool isDefault,
  }) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.addNewCard,
        requestBody: {
          'card_number': cardNumber.replaceAll(' ', ''),
          'cardholder_name': cardholderName,
          'expiry_month': expiryMonth,
          'expiry_year': expiryYear,
          'is_default': isDefault,
        },
      ),
      parser: (response) => response.data['message']?.toString() ?? 'Card added successfully',
    );
  }

  @override
  Future<Result<String>> deleteCard(int cardId) {
    return super.call(
      apiCall: () => _apiClient.delete(endpoint: Endpoints.deleteCard(cardId)),
      parser: (response) => response.data['message']?.toString() ?? 'Card deleted successfully',
    );
  }

  @override
  Future<Result<String>> convertPoints(int points) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.convertPoints,
        requestBody: {
          'points': points,
        },
      ),
      parser: (response) => response.data['message']?.toString() ?? 'Points converted successfully',
    );
  }

  @override
  Future<Result<CheckoutResponseDTO>> submitCheckout({
    required CheckoutParams params,
  }) {
    return super.call(
      apiCall: () => _apiClient.post(
        endpoint: Endpoints.ordersCheckout,
        requestBody: params.toJson(),
      ),
      parser: (response) => CheckoutResponseDTO.fromJson(response.data),
    );
  }

  @override
  Future<Result<OrderSummaryDTO>> getOrderSummary({String? voucher}) {
    return super.call(
      apiCall: () => _apiClient.get(
        endpoint: Endpoints.orderSummary,
        queryParameters: voucher != null ? {'voucher': voucher} : null,
      ),
      parser: (response) => OrderSummaryDTO.fromJson(response.data['data'] as Map<String, dynamic>),
    );
  }
}
