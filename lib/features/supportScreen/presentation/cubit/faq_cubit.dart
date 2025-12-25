import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/supportScreen/domain/entities/faq_entity.dart';
import 'package:gazzer/features/supportScreen/domain/faq_repo.dart';
import 'package:gazzer/features/supportScreen/presentation/cubit/faq_states.dart';

class FaqCubit extends Cubit<FaqStates> {
  final FaqRepo _repo;

  FaqCubit(this._repo) : super(FaqInitialState());

  Future<void> getFaqCategories(String type) async {
    emit(FaqLoadingState());

    // Try to load from cache first
    final cached = await _repo.getCachedFaqCategories(type);
    if (cached != null && cached.isNotEmpty) {
      emit(FaqSuccessState(cached, isFromCache: true));
    }

    // Fetch from API
    final result = await _repo.getFaqCategories(type);
    switch (result) {
      case final Ok<List<FaqCategoryEntity>> ok:
        emit(FaqSuccessState(ok.value));
        break;
      case final Err<List<FaqCategoryEntity>> err:
        emit(FaqErrorState(err.error.message));
        break;
    }
  }

  @override
  void emit(FaqStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
