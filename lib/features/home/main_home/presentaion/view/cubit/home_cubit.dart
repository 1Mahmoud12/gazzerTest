import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/main_home/domain/home_repo.dart';
import 'package:gazzer/features/home/main_home/presentaion/data/home_response_model.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo _repo;
  HomeCubit(this._repo) : super(HomeInitialState());

  // Future<void> getCategories() async {
  //   emit(CategoryLoadingState());
  //   final result = await _repo.getCategories();
  //   switch (result) {
  //     case Ok<List<CategoryEntity>> success:
  //       emit(CategorySuccessState(success.value));
  //       break;
  //     case Err error:
  //       emit(CategoryErrorState(error.error.message));
  //       break;
  //   }
  // }

  Future<void> getHomeData() async {
    emit(HomeDataLoadingState());
    final result = await _repo.getHome();
    switch (result) {
      case Ok<HomeDataModel> success:
        emit(HomeDataSuccessState(homeResponse: success.value));
        break;
      case Err error:
        emit(HomeDataErrorState(error.error.message));
        break;
    }
  }

  @override
  void emit(HomeStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
