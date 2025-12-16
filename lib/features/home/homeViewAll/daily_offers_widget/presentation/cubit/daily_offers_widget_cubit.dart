import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/domain/daily_offers_widget_repo.dart';
import 'package:gazzer/features/home/homeViewAll/daily_offers_widget/presentation/cubit/daily_offers_widget_states.dart';

class DailyOffersWidgetCubit extends Cubit<DailyOffersWidgetStates> {
  final DailyOffersWidgetRepo _repo;

  DailyOffersWidgetCubit(this._repo) : super(DailyOffersWidgetInitialState());

  Future<void> getDailyOffers() async {
    emit(DailyOffersWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedDailyOffers();
    final hasCachedData = cached != null && cached.entities.isNotEmpty;

    if (hasCachedData) {
      emit(DailyOffersWidgetSuccessState(cached.entities, cached.banner, isFromCache: true));
    }

    // Fetch data from API
    final res = await _repo.getDailyOffers();
    switch (res) {
      case Ok<DailyOffersWidgetData> ok:
        emit(DailyOffersWidgetSuccessState(ok.value.entities, ok.value.banner, isFromCache: false));
        break;
      case Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(DailyOffersWidgetErrorState(err.error.message));
        }
        break;
    }
  }

  @override
  void emit(DailyOffersWidgetStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
