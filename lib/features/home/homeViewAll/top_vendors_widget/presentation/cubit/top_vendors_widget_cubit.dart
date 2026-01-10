import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/data/services/local_storage.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/domain/top_vendors_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors_widget/presentation/cubit/top_vendors_widget_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TopVendorsWidgetCubit extends Cubit<TopVendorsWidgetState> {
  final TopVendorsWidgetRepo _repo;

  TopVendorsWidgetCubit(this._repo) : super(TopVendorsWidgetInitialState());

  Future<void> getTopVendors() async {
    emit(TopVendorsWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedTopVendors();
    final hasCachedData = cached != null && cached.vendors.isNotEmpty;

    if (hasCachedData) {
      emit(TopVendorsWidgetSuccessState(cached.vendors, cached.banner));
    }

    // Fetch data from API
    final res = await _repo.getTopVendors();
    switch (res) {
      case final Ok<TopVendorsWidgetData> ok:
        emit(TopVendorsWidgetSuccessState(ok.value.vendors, ok.value.banner));
        break;
      case final Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(TopVendorsWidgetErrorState(err.error.message));
        }
        break;
    }
  }

  Future<bool> shouldRefreshCache() async {
    try {
      final sp = await SharedPreferences.getInstance();
      final timestamp = sp.getInt(CacheKeys.topVendorsWidgetTs);
      if (timestamp == null) return true;

      final cacheAge = DateTime.now().millisecondsSinceEpoch - timestamp;
      const cacheExpiry = 3600000; // 1 hour in milliseconds
      return cacheAge > cacheExpiry;
    } catch (e) {
      return true;
    }
  }
}
