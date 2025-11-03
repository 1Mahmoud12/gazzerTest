import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';

abstract class CheckoutRepo extends BaseApiRepo {
  CheckoutRepo(super.crashlyticsRepo);

  Future<Result<CheckoutDataDTO>> getCheckoutData();

  Future<Result<List<VoucherDTO>>> getVouchers();

  Future<Result<VoucherDTO>> checkVoucher(String code);
}
