import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/domain/suggests_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/suggests_widget/presentation/cubit/suggests_widget_states.dart';

class SuggestsWidgetCubit extends Cubit<SuggestsWidgetStates> {
  SuggestsWidgetCubit(this._repo) : super(SuggestsWidgetInitialState());

  final SuggestsWidgetRepo _repo;

  Future<void> getSuggests() async {
    // Try to get cached data first
    final cached = await _repo.getCachedSuggests();
    final hasCachedData = cached != null && cached.entities.isNotEmpty;

    if (hasCachedData) {
      emit(
        SuggestsWidgetSuccessState(
          cached.entities,
          cached.banner,
          isFromCache: true,
        ),
      );
    }

    // Show loading if no cached data
    if (!hasCachedData) {
      emit(SuggestsWidgetLoadingState());
    }

    // Fetch from API
    final res = await _repo.getSuggests();

    switch (res) {
      case final Ok<SuggestsWidgetData> ok:
        emit(SuggestsWidgetSuccessState(ok.value.entities, ok.value.banner));
        break;
      case final Err err:
        // If API fails and we have cached data, keep showing it
        if (!hasCachedData) {
          emit(SuggestsWidgetErrorState(err.error.message));
        }
        break;
    }
  }
}
