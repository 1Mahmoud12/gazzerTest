import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/error_models.dart' as error_models;
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/features/orders/domain/orders_repo.dart';
import 'package:gazzer/features/orders/presentation/cubit/reorder_state.dart';

class ReorderCubit extends Cubit<ReorderState> {
  ReorderCubit(this._repo) : super(const ReorderInitial());

  final OrdersRepo _repo;
  int? _currentOrderId;

  Future<void> reorder(int orderId, {bool? continueWithExisting}) async {
    _currentOrderId = orderId;
    emit(ReorderLoading(orderId: orderId));
    animationDialogLoading();
    final result = await _repo.reorder(orderId, continueWithExisting: continueWithExisting);
    closeDialog();
    switch (result) {
      case Ok<String>(:final value):
        emit(ReorderSuccess(message: value));
      case Err<String>(:final error):
        // Check if this is a ReorderError with existing items
      //logger.d('Errors ==>${error.runtimeType}');
        if (error is error_models.ReorderError && error.hasExistingItems) {
          emit(
            ReorderHasExistingItems(
              message: error.message,
              existingItemsCount: error.existingItemsCount,
              detailedMessage: error.detailedMessage,
            ),
          );
        } else {
          emit(ReorderErrorState(message: error.message));
        }
    }
  }

  Future<void> continueReorder(bool keepExistingItems) async {
    if (_currentOrderId != null) {
      await reorder(_currentOrderId!, continueWithExisting: keepExistingItems);
    }
  }
}
