import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/domain/vendor_entity.dart';
import 'package:gazzer/features/home/top_vendors/domain/top_vendors_repo.dart';
import 'package:gazzer/features/home/top_vendors/presentation/cubit/top_vendors_states.dart';

class TopVendorsCubit extends Cubit<TopVendorsStates> {
  final TopVendorsRepo _repo;

  TopVendorsCubit(this._repo) : super(TopVendorsInitialState());

  Future<void> getTopVendors() async {
    emit(TopVendorsLoadingState());

    // Check cache first
    final cached = await _repo.getCachedTopVendors();
    final hasCachedData = cached != null && cached.isNotEmpty;

    if (hasCachedData) {
      emit(TopVendorsSuccessState(cached));
    }

    // Fetch data from API
    final res = await _repo.getTopVendors();
    switch (res) {
      case Ok<List<VendorEntity>> ok:
        emit(TopVendorsSuccessState(ok.value));
        break;
      case Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(TopVendorsErrorState(err.error.message));
        }
        break;
    }
  }

  @override
  void emit(TopVendorsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
