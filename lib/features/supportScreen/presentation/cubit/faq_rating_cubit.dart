import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/data/requests/faq_rating_request.dart';
import 'package:gazzer/features/supportScreen/domain/faq_rating_repo.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_rating_states.dart';

class FaqRatingCubit extends Cubit<FaqRatingStates> {
  final FaqRatingRepo _repo;

  FaqRatingCubit(this._repo) : super(FaqRatingInitialState());

  Future<void> submitRating(FaqRatingRequest request) async {
    emit(FaqRatingLoadingState());

    final result = await _repo.submitRating(request);
    switch (result) {
      case final Ok<String> ok:
        emit(FaqRatingSuccessState(ok.value));
        break;
      case final Err<String> err:
        emit(FaqRatingErrorState(err.error.message));
        break;
    }
  }

  @override
  void emit(FaqRatingStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
