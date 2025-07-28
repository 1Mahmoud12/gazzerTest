import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/extensions/cancel_token.dart';
import 'package:gazzer/features/vendors/resturants/domain/enities/ordered_with_entityy.dart';
import 'package:gazzer/features/vendors/resturants/domain/repos/restaurants_repo.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/cubit/ordered_with_cubit/ordered_with_states.dart';

class OrderedWithCubit extends Cubit<OrderedWithStates> {
  final RestaurantsRepo restaurantsRepo;
  final int restId;
  OrderedWithCubit(this.restaurantsRepo, this.restId) : super(OrderedWithInitial());
  CancelToken cancelToken = CancelToken();
  void loadItems(int plateId) async {
    if (state is OrderedWithLoading) cancelToken = cancelToken.regenerate();
    // Prevent multiple loads
    emit(OrderedWithLoading());
    final items = await restaurantsRepo.getPlateOrderedWith(restId, plateId, cancelToken: cancelToken);
    switch (items) {
      case Ok<List<OrderedWithEntityy>> ok:
        emit(OrderedWithLoaded(items: ok.value));
      case Err err:
        emit(OrderedWithError(message: err.error.message));
    }
  }

  @override
  void emit(OrderedWithStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
