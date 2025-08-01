import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_menu_response.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_menu/cubit/store_menu_states.dart';

class StoresMenuCubit extends Cubit<StoresMenuStates> {
  final StoresRepo storeRepo;
  final int mainId;
  StoresMenuCubit(this.storeRepo, this.mainId) : super(StoresMenuInit()) {
    loadScreenData();
  }

  Future<void> loadScreenData() async {
    emit(ScreenDataLoading());
    final result = await storeRepo.loadStoresMenuPage(mainId);
    switch (result) {
      case Ok<StoresMenuResponse> data:
        emit(
          ScreenDataLoaded(
            mainCategory: data.value.mainCategory,
            banners: data.value.banners,
            categoryWithStores: data.value.categoryWzStores,
          ),
        );
        break;
      case Err error:
        emit(ScreenDataError(error: error.error.message));
    }
  }
}
