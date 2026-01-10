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

  Future<void> loadScreenData({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      emit(ScreenDataLoading());
      // Check cache first
      final cached = await storeRepo.getCachedStoresMenuPage(mainId);
      final hasCachedData =
          cached != null && cached.categoryWzStores.isNotEmpty;

      if (hasCachedData) {
        emit(
          ScreenDataLoaded(
            mainCategory: cached.mainCategory,
            banners: cached.banners,
            categoryWithStores: cached.categoryWzStores,
          ),
        );
      }
    } else {
      emit(ScreenDataLoading());
    }

    // Fetch data from API
    final result = await storeRepo.loadStoresMenuPage(mainId);
    switch (result) {
      case final Ok<StoresMenuResponse> data:
        emit(
          ScreenDataLoaded(
            mainCategory: data.value.mainCategory,
            banners: data.value.banners,
            categoryWithStores: data.value.categoryWzStores,
          ),
        );
        break;
      case final Err error:
        // If we have cached data, don't show error, just keep showing cache
        final cached = await storeRepo.getCachedStoresMenuPage(mainId);
        if (cached == null || cached.categoryWzStores.isEmpty) {
          emit(ScreenDataError(error: error.error.message));
        }
        break;
    }
  }

  @override
  void emit(StoresMenuStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
