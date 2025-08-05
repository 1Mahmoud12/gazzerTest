import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';

sealed class AddEditAddressStates {}

class AddEditAddressInit extends AddEditAddressStates {}

sealed class SaveAddressStates extends AddEditAddressStates {}

class SaveAddressLoading extends SaveAddressStates {}

class SaveAddressSuccess extends SaveAddressStates {
  final String message;
  SaveAddressSuccess(this.message);
}

class SaveAddressError extends SaveAddressStates {
  final String error;
  SaveAddressError(this.error);
}

sealed class GetAddressesStates extends AddEditAddressStates {
  final List<AddressEntity> addresses;
  GetAddressesStates({this.addresses = const []});
}

class GetAddressesLoading extends GetAddressesStates {
  GetAddressesLoading({super.addresses = Fakers.addresses});
}

class GetAddressesSuccess extends GetAddressesStates {
  GetAddressesSuccess({required super.addresses});
}

class GetAddressesError extends GetAddressesStates {
  final String error;
  GetAddressesError(this.error);
}

///
///
sealed class GetProvincesStates extends AddEditAddressStates {
  final List<({int id, String name})> provinces;
  GetProvincesStates({this.provinces = const []});
}

class GetProvincesLoading extends GetProvincesStates {}

class GetProvincesSuccess extends GetProvincesStates {
  GetProvincesSuccess({required super.provinces});
}

class GetProvincesError extends GetProvincesStates {
  final String error;
  GetProvincesError(this.error);
}

///
///
sealed class GetZonesStates extends AddEditAddressStates {
  final List<({int id, String name})> zones;
  GetZonesStates({this.zones = const []});
}

class GetZonesLoading extends GetZonesStates {}

class GetZonesSuccess extends GetZonesStates {
  GetZonesSuccess({required super.zones});
}

class GetZonesError extends GetZonesStates {
  final String error;
  GetZonesError(this.error);
}
