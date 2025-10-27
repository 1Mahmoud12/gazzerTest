import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/store_details_response.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/cubit/store_details_states.dart';

class StoreDetailsCubit extends Cubit<StoreDetailsStates> {
  final int storeId;
  final StoresRepo _repo;
  StoreDetailsCubit(this._repo, this.storeId) : super(StoreDetailsInitial()) {
    loadScreenData();
  }

  Future<void> loadScreenData() async {
    emit(StoreDetailsLoading());
    final response = await _repo.loadStoreDetails(storeId);
    switch (response) {
      case Ok<StoreDetailsResponse> ok:
        emit(
          StoreDetailsLoaded(
            store: ok.value.store,
            catsWthSubatsAndProds: ok.value.catsWithProds,
            bestSellingItems: ok.value.bestSellingItems,
          ),
        );
        break;
      case Err err:
        emit(StoreDetailsError(message: err.error.message));
        break;
    }
  }

  @override
  void emit(StoreDetailsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
