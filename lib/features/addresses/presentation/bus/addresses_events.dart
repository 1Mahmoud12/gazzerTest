import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';

sealed class AddressesEvents extends AppEvent {}

///
sealed class FetchAddressesEvents extends AddressesEvents {
  final List<AddressEntity> addresses;
  FetchAddressesEvents({this.addresses = const []});
}

class FetchAddressesLoading extends FetchAddressesEvents {
  FetchAddressesLoading({super.addresses = Fakers.addresses});
}

class FetchAddressesSuccess extends FetchAddressesEvents {
  FetchAddressesSuccess({required super.addresses});
}

class FetchAddressesError extends FetchAddressesEvents {
  final String error;
  FetchAddressesError(this.error);
}

sealed class AddressCardEvents extends AddressesEvents {
  final int id;
  AddressCardEvents({required this.id});
}

sealed class AddressCardErrors extends AddressCardEvents {
  final String error;
  AddressCardErrors(this.error, {required super.id});
}

///
sealed class SetDefaultEvents extends AddressCardEvents {
  SetDefaultEvents({required super.id});
}

class SetDefaultLoading extends SetDefaultEvents {
  SetDefaultLoading({required super.id});
}

class SetDefaultSuccess extends SetDefaultEvents {
  SetDefaultSuccess({required super.id});
}

class SetDefaultError extends AddressCardErrors {
  SetDefaultError(super.error, {required super.id});
}

///
sealed class DeleteAddress extends AddressCardEvents {
  DeleteAddress({required super.id});
}

class DeleteAddressLoading extends DeleteAddress {
  DeleteAddressLoading({required super.id});
}

class DeleteAddressSuccess extends DeleteAddress {
  DeleteAddressSuccess({required super.id});
}

class DeleteAddressError extends AddressCardErrors {
  DeleteAddressError(super.error, {required super.id});
}
