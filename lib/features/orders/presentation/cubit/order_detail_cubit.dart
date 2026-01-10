import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit(this._repo, this._orderId) : super(const OrderDetailInitial());

  final OrdersRepo _repo;
  final int _orderId;

  Future<void> loadOrderDetail({bool refresh = false}) async {
    // Load cached data first if not refreshing
    if (!refresh) {
      final cached = await _repo.getCachedOrderDetail(_orderId);
      if (cached != null) {
        emit(OrderDetailLoaded(orderDetail: cached));
        // Continue to refresh in background
      }
    }

    emit(OrderDetailLoading(orderDetail: state is OrderDetailLoaded ? (state as OrderDetailLoaded).orderDetail : null));

    final result = await _repo.getOrderDetail(_orderId);

    switch (result) {
      case Ok<OrderDetailEntity>(:final value):
        emit(OrderDetailLoaded(orderDetail: value));
      case Err<OrderDetailEntity>(:final error):
        emit(OrderDetailError(message: error.message, orderDetail: state is OrderDetailLoaded ? (state as OrderDetailLoaded).orderDetail : null));
    }
  }
}
