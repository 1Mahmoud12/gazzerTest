import 'package:gazzer/core/data/network/api_client.dart';
import 'package:gazzer/core/data/network/endpoints.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/top_vendors/data/dtos/top_vendors_dto.dart';
import 'package:gazzer/features/home/top_vendors/domain/top_vendors_repo.dart';

class TopVendorsRepoImp extends TopVendorsRepo {
  final ApiClient _apiClient;

  TopVendorsRepoImp(this._apiClient, super.crashlyticsRepo);

  @override
  Future<Result<List<VendorEntity>>> getTopVendors() {
    return super.call(
      apiCall: () => _apiClient.get(endpoint: Endpoints.topVendors),
      parser: (response) {
        final dto = TopVendorsDto.fromJson(response.data);
        return dto.data?.entities
                .map(
                  (vendor) => VendorEntity(
                    id: vendor.id ?? 0,
                    storeId: vendor.storeInfo?.storeId ?? 0,
                    name: vendor.vendorName ?? '',
                    contactPerson: vendor.contactPerson,
                    secondContactPerson: vendor.secondContactPerson,
                    image: vendor.image ?? '',
                    type: vendor.storeInfo?.storeCategoryType ?? '',
                  ),
                )
                .toList() ??
            [];
      },
    );
  }
}
