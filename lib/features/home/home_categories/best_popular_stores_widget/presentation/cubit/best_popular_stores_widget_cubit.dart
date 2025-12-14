import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/home_categories/best_popular_stores_widget/domain/best_popular_stores_widget_repo.dart';
import 'package:gazzer/features/home/home_categories/best_popular_stores_widget/presentation/cubit/best_popular_stores_widget_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BestPopularStoresWidgetCubit extends Cubit<BestPopularStoresWidgetState> {
  final BestPopularStoresWidgetRepo _repo;

  BestPopularStoresWidgetCubit(this._repo) : super(BestPopularStoresWidgetInitialState());

  Future<void> getBestPopularStores() async {
    emit(BestPopularStoresWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedBestPopularStores();
    final hasCachedData = cached != null && cached.stores.isNotEmpty;

    if (hasCachedData) {
      emit(BestPopularStoresWidgetSuccessState(cached.stores, cached.banner));
    }

    // Fetch data from API
    final res = await _repo.getBestPopularStores();
    switch (res) {
      case Ok<BestPopularStoresWidgetData> ok:
        emit(BestPopularStoresWidgetSuccessState(ok.value.stores, ok.value.banner));
        break;
      case Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(BestPopularStoresWidgetErrorState(err.error.message));
        }
        break;
    }
  }

  Future<bool> shouldRefreshCache() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final timestamp = sp.getInt(CacheKeys.bestPopularStoresWidgetTs);
      if (timestamp == null) return true;

      final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
      const cacheExpiry = 3600000; // 1 hour in milliseconds
      return cacheAge > cacheExpiry;
    } catch (e) {
      return true;
    }
  }
}
