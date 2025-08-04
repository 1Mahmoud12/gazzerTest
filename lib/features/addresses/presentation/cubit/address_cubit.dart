import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/features/addresses/domain/address_repo.dart';
import 'package:gazzer/features/addresses/presentation/cubit/address_states.dart';

class AddressCubit extends Cubit<AddressStates> {
  final AddressRepo _repo;
  AddressCubit(this._repo) : super(AddAddressInit());
}
