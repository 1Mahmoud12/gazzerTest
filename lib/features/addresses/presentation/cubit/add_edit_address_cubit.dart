import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/addresses/data/address_request.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/domain/address_repo.dart';
import 'package:gazzer/features/addresses/presentation/cubit/add_edit_address_states.dart';

class AddEditAddressCubit extends Cubit<AddEditAddressStates> {
  final AddressRepo _repo;
  final AddressEntity? oldAddress;
  AddEditAddressCubit(this._repo, {this.oldAddress}) : super(AddEditAddressInit());

  Future<void> getProvinces() async {
    emit(GetProvincesLoading());
    final result = await _repo.getProvinces();
    switch (result) {
      case Ok<List<({int id, String name})>> data:
        emit(GetProvincesSuccess(provinces: data.value));
        break;
      case Err err:
        emit(GetProvincesError(err.error.message));
        break;
    }
  }

  Future<void> getZones(int id) async {
    emit(GetZonesLoading());
    final result = await _repo.getZonez(id);
    switch (result) {
      case Ok<List<({int id, String name})>> data:
        emit(GetZonesSuccess(zones: data.value));
        break;
      case Err err:
        emit(GetZonesError(err.error.message));
        break;
    }
  }

  Future<void> saveAddress(AddressRequest req) async {
    emit(SaveAddressLoading());
    final Result<String> result;
    if (oldAddress == null) {
      result = await _repo.addAddress(req);
    } else {
      req.id = oldAddress!.id;
      result = await _repo.editAddress(req);
    }
    switch (result) {
      case Ok<String> data:
        emit(SaveAddressSuccess(data.value));
        break;
      case Err err:
        emit(SaveAddressError(err.error.message));
        break;
    }
  }
}
