import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/stores/data/dtos/stores_of_category_response.dart';
import 'package:gazzer/features/vendors/stores/domain/stores_repo.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/stores_of_category/view/cubit/stores_of_category_states.dart';

class StoresOfCategoryCubit extends Cubit<StoresOfCategoryStates> {
  final StoresRepo _repo;
  final int mainCatId;
  final int subCatId;
  StoresOfCategoryCubit(this._repo, this.mainCatId, this.subCatId) : super(StoresOfCategoryInitial()) {
    loadStoresOfCategory();
  }

  Future<void> loadStoresOfCategory() async {
    emit(StoresOfCategoryLoading());
    final result = await _repo.loadStoresOfCategoryPage(mainCatId, subCatId);
    switch (result) {
      case Ok<StoresOfCategoryResponse> ok:
        emit(
          StoresOfCategoryLoaded(
            todaysDeals: ok.value.todaysDeals,
            stores: ok.value.stores,
            subCategory: ok.value.subCategory,
          ),
        );
        break;
      case Err err:
        emit(StoresOfCategoryError(message: err.error.message));
    }
  }
}
