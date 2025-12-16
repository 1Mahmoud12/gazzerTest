import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/top_items_widget/domain/top_items_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/top_items_widget/presentation/cubit/top_items_widget_states.dart';

class TopItemsWidgetCubit extends Cubit<TopItemsWidgetState> {
  final TopItemsWidgetRepo _repo;

  TopItemsWidgetCubit(this._repo) : super(TopItemsWidgetInitialState());

  Future<void> getTopItems() async {
    emit(TopItemsWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedTopItems();
    final hasCachedData = cached != null && cached.entities.isNotEmpty;

    if (hasCachedData) {
      emit(TopItemsWidgetSuccessState(cached.entities, cached.banner));
    }

    // Fetch data from API
    final res = await _repo.getTopItems();
    switch (res) {
      case Ok<TopItemsWidgetData> ok:
        emit(TopItemsWidgetSuccessState(ok.value.entities, ok.value.banner));
        break;
      case Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(TopItemsWidgetErrorState(err.error.message));
        }
        break;
    }
  }
}
