import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_details_response.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/plates_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/cubit/plate_details_states.dart';

class PlateDetailsCubit extends Cubit<PlateDetailsStates> {
  final PlatesRepo _repo;
  final int plateId;
  PlateDetailsCubit(this._repo, this.plateId) : super(PlateDetailsInitial()) {
    loadPlateDetails();
  }

  Future<void> loadPlateDetails() async {
    emit(PlateDetailsLoading());
    final result = await _repo.getPlateDetails(plateId);
    switch (result) {
      case Ok<PlateDetailsResponse> ok:
        emit(
          PlateDetailsLoaded(
            plate: ok.value.plate,
            options: ok.value.options,
            orderedWith: ok.value.orderedWith,
          ),
        );
        break;
      case Err err:
        emit(PlateDetailsError(message: err.error.message));
        break;
    }
  }

  @override
  void emit(PlateDetailsStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
