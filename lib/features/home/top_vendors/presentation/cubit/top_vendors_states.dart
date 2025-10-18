import 'package:gazzer/core/domain/vendor_entity.dart';

sealed class TopVendorsStates {}

final class TopVendorsInitialState extends TopVendorsStates {}

final class TopVendorsLoadingState extends TopVendorsStates {}

final class TopVendorsSuccessState extends TopVendorsStates {
  final List<VendorEntity> vendors;

  TopVendorsSuccessState(this.vendors);
}

final class TopVendorsErrorState extends TopVendorsStates {
  final String error;

  TopVendorsErrorState(this.error);
}
