import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/dailyOffers/data/dtos/daily_offers_dto.dart';
import 'package:gazzer/features/dailyOffers/domain/daily_offer_repo.dart';
import 'package:gazzer/features/dailyOffers/presentation/cubit/daily_offer_states.dart';

class DailyOfferCubit extends Cubit<DailyOfferStates> {
  final DailyOfferRepo _repo;

  DailyOfferCubit(this._repo) : super(DailyOfferInitialState());

  Future<void> getAllOffers() async {
    emit(DailyOfferLoadingState());
    final res = await _repo.getAllDailyOffer();
    switch (res) {
      case Ok<DailyOfferDataModel?> ok:
        emit(DailyOfferSuccessState(ok.value));
        break;
      case Err err:
        emit(DailyOfferErrorState(err.error.message));
        break;
    }
  }

  @override
  void emit(DailyOfferStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
