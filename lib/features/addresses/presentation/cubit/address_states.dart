import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';

sealed class AddressStates {}

class AddAddressInit extends AddressStates {}

class AddAddressLoading extends AddressStates {}

class AddAddressSuccess extends AddressStates {
  final String message;

  AddAddressSuccess(this.message);
}

class AddAddressError extends AddressStates {
  final String error;
  AddAddressError(this.error);
}

sealed class GetAddressesStates extends AddressStates {
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
sealed class GetPRovincesStates extends AddressStates {
  final List<({int id, String name})> provinces;
  GetPRovincesStates({this.provinces = const []});
}

class GetProvincesLoading extends GetPRovincesStates {}

class GetProvincesSuccess extends GetPRovincesStates {
  GetProvincesSuccess({required super.provinces});
}

class GetProvincesError extends GetPRovincesStates {
  final String error;
  GetProvincesError(this.error);
}

///
///
sealed class GetZonezStates extends AddressStates {
  final List<({int id, String name})> zones;
  GetZonezStates({this.zones = const []});
}

class GetZonezLoading extends GetZonezStates {}

class GetZonezSuccess extends GetZonezStates {
  GetZonezSuccess({required super.zones});
}

class GetZonezError extends GetZonezStates {
  final String error;
  GetZonezError(this.error);
}
