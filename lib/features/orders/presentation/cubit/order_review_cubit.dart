import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/order_review_state.dart';

class OrderReviewCubit extends Cubit<OrderReviewState> {
  OrderReviewCubit(this._repo) : super(const OrderReviewInitial());

  final OrdersRepo _repo;

  Future<void> submitReview({
    required int orderId,
    required List<StoreReview> storeReviews,
    required DeliveryManReview deliveryManReview,
  }) async {
    emit(const OrderReviewLoading());
    animationDialogLoading();
    final result = await _repo.submitOrderReview(
      orderId: orderId,
      storeReviews: storeReviews,
      deliveryManReview: deliveryManReview,
    );
    closeDialog();
    switch (result) {
      case Ok<String>(:final value):
        emit(OrderReviewSuccess(message: value));
      case Err<String>(:final error):
        emit(OrderReviewError(message: error.message));
    }
  }
}
