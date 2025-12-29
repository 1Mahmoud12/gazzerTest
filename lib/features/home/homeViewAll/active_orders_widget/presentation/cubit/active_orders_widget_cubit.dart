import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/home/homeViewAll/active_orders_widget/presentation/cubit/active_orders_widget_states.dart';
import 'package:gazzer/features/orders/domain/entities/active_order_entity.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';

class ActiveOrdersWidgetCubit extends Cubit<ActiveOrdersWidgetStates> {
  final OrdersRepo _repo;

  ActiveOrdersWidgetCubit(this._repo) : super(ActiveOrdersWidgetInitialState());

  Future<void> getActiveOrders() async {
    emit(ActiveOrdersWidgetLoadingState());

    // Check cache first
    final cached = await _repo.getCachedActiveOrders();
    final hasCachedData = cached != null && cached.isNotEmpty;

    if (hasCachedData) {
      emit(ActiveOrdersWidgetSuccessState(cached, isFromCache: true));
    }

    // Fetch data from API
    final res = await _repo.getActiveOrders();
    switch (res) {
      case final Ok<List<ActiveOrderEntity>> ok:
        emit(ActiveOrdersWidgetSuccessState(ok.value, isFromCache: false));
        break;
      case final Err err:
        // If we have cached data, don't show error, just keep showing cache
        if (!hasCachedData) {
          emit(ActiveOrdersWidgetErrorState(err.error.message));
        }
        break;
    }
  }

  @override
  void emit(ActiveOrdersWidgetStates state) {
    if (isClosed) return;
    super.emit(state);
  }
}
