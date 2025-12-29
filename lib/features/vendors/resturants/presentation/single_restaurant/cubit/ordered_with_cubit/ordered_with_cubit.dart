import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/cancel_token.dart';
import 'package:gazzer/features/vendors/common/domain/generic_item_entity.dart.dart';
import 'package:gazzer/features/vendors/resturants/data/dtos/plate_details_response.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/plates_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_states.dart';

class SingleCatRestaurantCubit extends Cubit<SingleCatRestaurantStates> {
  final PlatesRepo _repo;
  final int restId;
  SingleCatRestaurantCubit(this._repo, this.restId, int firstPlateId) : super(OrderedWithInitial()) {
    loadItems(firstPlateId);
    loadPlateDetails(firstPlateId);
  }
  CancelToken cancelToken = CancelToken();

  void loadItems(int plateId) async {
    if (state is OrderedWithLoading) cancelToken = cancelToken.regenerate();
    // Prevent multiple loads
    emit(OrderedWithLoading());
    final items = await _repo.getPlateOrderedWith(restId, plateId, cancelToken: cancelToken);
    switch (items) {
      case final Ok<List<OrderedWithEntity>> ok:
        emit(OrderedWithLoaded(items: ok.value));
      case final Err err:
        emit(OrderedWithError(message: err.error.message));
    }
  }

  Future<void> loadPlateDetails(int plateId) async {
    emit(PlateDetailsLoading());
    final result = await _repo.getPlateDetails(plateId);
    switch (result) {
      case final Ok<PlateDetailsResponse> ok:
        emit(PlateDetailsLoaded(plate: ok.value.plate, options: ok.value.options, orderedWith: ok.value.orderedWith));
        break;
      case final Err err:
        emit(PlateDetailsError(message: err.error.message));
        break;
    }
  }

  @override
  void emit(SingleCatRestaurantStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
