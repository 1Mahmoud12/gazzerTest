import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this._repo) : super(const OrdersInitial());

  final OrdersRepo _repo;
  List<OrderItemEntity> _allOrders = [];
  int _currentPage = 1;
  bool _hasMore = true;
  static const int _perPage = 10;

  Future<void> loadOrders({bool refresh = false}) async {
    if (refresh) {
      _allOrders = [];
      _currentPage = 1;
      _hasMore = true;
    }

    // Load cached data first if initial load
    if (!refresh && _currentPage == 1 && _allOrders.isEmpty) {
      final cached = await _repo.getCachedClientOrders();
      if (cached != null && cached.isNotEmpty) {
        _allOrders = cached;
        emit(
          OrdersLoaded(
            orders: List.from(_allOrders),
            hasMore: true,
            currentPage: 1,
          ),
        );
        // Continue to refresh in background
      }
    }

    if (!_hasMore && !refresh) {
      return;
    }

    emit(OrdersLoading(orders: List.from(_allOrders), hasMore: _hasMore));

    final result = await _repo.getClientOrders(
      page: _currentPage,
      perPage: _perPage,
    );

    switch (result) {
      case Ok<List<OrderItemEntity>>(:final value):
        if (refresh || _currentPage == 1) {
          _allOrders = value;
        } else {
          _allOrders.addAll(value);
        }

        _hasMore = value.length >= _perPage;
        _currentPage++;

        emit(
          OrdersLoaded(
            orders: List.from(_allOrders),
            hasMore: _hasMore,
            currentPage: _currentPage - 1,
          ),
        );
      case Err<List<OrderItemEntity>>(:final error):
        emit(
          OrdersError(
            message: error.message,
            orders: _allOrders,
          ),
        );
    }
  }

  Future<void> loadMore() {
    if (state is OrdersLoaded && _hasMore) {
      return loadOrders();
    }
    return Future.value();
  }
}
