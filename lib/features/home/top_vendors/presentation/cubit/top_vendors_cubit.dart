import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/top_vendors/domain/top_vendors_repo.dart';
import 'package:gazzer/features/home/top_vendors/presentation/cubit/top_vendors_states.dart';

class TopVendorsCubit extends Cubit<TopVendorsStates> {
  final TopVendorsRepo _repo;

  TopVendorsCubit(this._repo) : super(TopVendorsInitialState());

  Future<void> getTopVendors() async {
    emit(TopVendorsLoadingState());
    final res = await _repo.getTopVendors();
    switch (res) {
      case Ok ok:
        emit(TopVendorsSuccessState(ok.value));
        break;
      case Err err:
        emit(TopVendorsErrorState(err.error.message));
        break;
    }
  }

  @override
  void emit(TopVendorsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
