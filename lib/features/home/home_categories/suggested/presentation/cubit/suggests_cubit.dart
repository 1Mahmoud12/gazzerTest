import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/home_categories/suggested/data/dtos/suggests_dto.dart';
import 'package:gazzer/features/home/home_categories/suggested/domain/suggests_repo.dart';
import 'package:gazzer/features/home/home_categories/suggested/presentation/cubit/suggests_states.dart';

class SuggestsCubit extends Cubit<SuggestsStates> {
  final SuggestsRepo _repo;

  SuggestsCubit(this._repo) : super(SuggestsInitialState());

  Future<void> getSuggests() async {
    emit(SuggestsLoadingState());

    // Try to get cached data first
    final cached = await _repo.getCachedSuggests();
    final hasCachedData = cached != null && cached.entities.isNotEmpty;

    if (hasCachedData) {
      emit(SuggestsSuccessState(cached, isFromCache: true));
    }

    // Fetch fresh data from API
    final res = await _repo.getSuggests();
    switch (res) {
      case final Ok<SuggestsDtoData?> ok:
        emit(SuggestsSuccessState(ok.value));
        break;
      case final Err err:
        emit(SuggestsErrorState(err.error.message));
        break;
    }
  }

  @override
  void emit(SuggestsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
