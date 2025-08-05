import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/resources/session.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/addresses/domain/address_entity.dart';
import 'package:gazzer/features/addresses/domain/address_repo.dart';
import 'package:gazzer/features/addresses/presentation/bus/addresses_events.dart';

class AddressesBus extends AppBus {
  AddressesBus(this._repo);
  final AddressRepo _repo;

  Future<void> refreshAddresses() async {
    fire(FetchAddressesLoading());
    final result = await _repo.getAddresses();
    switch (result) {
      case Ok<List<AddressEntity>> data:
        Session().addresses.clear();
        Session().addresses.addAll(data.value);
        fire(FetchAddressesSuccess(addresses: data.value));
        break;
      case Err err:
        fire(FetchAddressesError(err.error.message));
        break;
    }
  }

  Future<void> setDefault(int id) async {
    fire(SetDefaultLoading(id: id));
    final result = await _repo.setDefaultAddress(id);
    switch (result) {
      case Ok<String> ok:
        refreshAddresses();
        Alerts.showToast(ok.value, error: false);
        fire(SetDefaultSuccess(id: id));
        break;
      case Err err:
        fire(SetDefaultError(err.error.message, id: id));
        break;
    }
  }

  Future<void> deleteAddress(int id) async {
    fire(DeleteAddressLoading(id: id));
    final result = await _repo.deleteAddress(id);
    switch (result) {
      case Ok<String> ok:
        Alerts.showToast(ok.value, error: false);
        refreshAddresses();
        fire(DeleteAddressSuccess(id: id));
        break;
      case Err err:
        fire(DeleteAddressError(err.error.message, id: id));
        break;
    }
  }
}
