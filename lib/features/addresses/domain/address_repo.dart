import 'package:gazzer/core/data/network/base_repo.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/addresses/data/address_request.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';

abstract class AddressRepo extends BaseApiRepo {
  AddressRepo(super.crashlyticsRepo);

  Future<Result<List<AddressEntity>>> getAddresses();
  Future<Result<String>> addAddress(AddressRequest address);
  Future<Result<String>> editAddress(AddressRequest address);
  Future<Result<String>> deleteAddress(int addressId);
  Future<Result<String>> setDefaultAddress(int addressId);

  Future<Result<List<({int id, String name})>>> getProvinces();
  Future<Result<List<({int id, String name})>>> getZonez(int id);
}
