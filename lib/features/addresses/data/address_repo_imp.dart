import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/addresses/data/address_dto.dart';
import 'package:gazzer/features/addresses/data/address_request.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/domain/address_repo.dart';

class AddressRepoImp extends AddressRepo {
  final ApiClient _apiClient;

  AddressRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<AddressEntity>>> getAddresses() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.addresses),
      parser: (response) {
        final addresses = <AddressEntity>[];
        for (final item in response.data['data']) {
          addresses.add(AddressDTO.fromJson(item).toEntity());
        }
        return addresses;
      },
    );
  }

  @override
  Future<Result<String>> addAddress(AddressRequest address) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.addAddress, requestBody: address.toJson()),
      parser: (response) => response.data['message'].toString(),
    );
  }

  @override
  Future<Result<String>> editAddress(AddressRequest address) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.editAddress(address.id!), requestBody: address.toJson()),
      parser: (response) => response.data['message'].toString(),
    );
  }

  @override
  Future<Result<String>> deleteAddress(int addressId) {
    return super.call(
      apiCall: () => _apiClient.delete(endpoint: Endpoints.deleteAddress(addressId)),
      parser: (response) => response.data['message'].toString(),
    );
  }

  @override
  Future<Result<String>> setDefaultAddress(int addressId) {
    return super.call(
      apiCall: () => _apiClient.post(endpoint: Endpoints.setDefaultAddress, requestBody: {'address_id': addressId}),
      parser: (response) => response.data['message'].toString(),
    );
  }

  @override
  Future<Result<List<({int id, String name})>>> getProvinces() {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.getProvinces),
      parser: (response) {
        final data = response.data['data'] as List<dynamic>;
        return data.map<({int id, String name})>((item) => (id: item['id'], name: item['province_name'])).toList();
      },
    );
  }

  @override
  Future<Result<List<({int id, String name})>>> getZonez(int id) {
    return super.call(
      apiCall: () async => _apiClient.get(endpoint: Endpoints.getZones(id)),
      parser: (response) {
        final data = response.data['data'] as List<dynamic>;
        return data.map<({int id, String name})>((item) => (id: item['id'], name: item['zone_name'])).toList();
      },
    );
  }
}
