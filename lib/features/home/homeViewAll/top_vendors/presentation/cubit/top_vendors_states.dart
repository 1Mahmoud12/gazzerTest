import 'package:gazzer/core/data/dto/pagination_dto.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';

sealed class TopVendorsStates {}

final class TopVendorsInitialState extends TopVendorsStates {}

final class TopVendorsLoadingState extends TopVendorsStates {}

final class TopVendorsLoadingMoreState extends TopVendorsStates {
  final List<VendorEntity> vendors;
  final PaginationInfo? pagination;

  TopVendorsLoadingMoreState(this.vendors, this.pagination);
}

final class TopVendorsSuccessState extends TopVendorsStates {
  final List<VendorEntity> vendors;
  final PaginationInfo? pagination;

  TopVendorsSuccessState(this.vendors, {this.pagination});
}

final class TopVendorsErrorState extends TopVendorsStates {
  final String error;

  TopVendorsErrorState(this.error);
}
