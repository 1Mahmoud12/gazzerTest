import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/home_categories/popular/data/dtos/top_items_dto.dart';
import 'package:gazzer/features/home/home_categories/popular/domain/top_items_repo.dart';
import 'package:gazzer/features/home/home_categories/popular/presentation/cubit/top_items_states.dart';

class TopItemsCubit extends Cubit<TopItemsStates> {
  final TopItemsRepo _repo;

  TopItemsCubit(this._repo) : super(TopItemsInitialState());

  Future<void> getTopItems() async {
    emit(TopItemsLoadingState());

    // Only use cache when there's no search query
    final cached = await _repo.getCachedTopItems();
    final hasCachedData = cached != null && cached.entities.isNotEmpty;

    if (hasCachedData) {
      emit(TopItemsSuccessState(cached, isFromCache: true));
    }

    // Fetch data from API
    final res = await _repo.getTopItems();
    switch (res) {
      case final Ok<TopItemsDtoData?> ok:
        emit(TopItemsSuccessState(ok.value));
        break;
      case final Err err:
        emit(TopItemsErrorState(err.error.message));
        break;
    }
  }

  @override
  void emit(TopItemsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
