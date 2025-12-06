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

  Future<void> reorder(int orderId, {bool? continueWithExisting, bool? addNewPouch}) async {
    _currentOrderId = orderId;
    emit(ReorderLoading(orderId: orderId));
    animationDialogLoading();
    final result = await _repo.reorder(orderId, continueWithExisting: continueWithExisting, addNewPouch: addNewPouch);
    closeDialog();
    switch (result) {
      case Ok<String>(:final value):
        emit(ReorderSuccess(message: value));
      case Err<String>(:final error):
        // Check if this is a ReorderError with existing items
        //logger.d('Errors ==>${error.runtimeType}');
        if (error is error_models.ReorderError && (error.hasExistingItems || error.addNewPouchApproval)) {
          emit(
            ReorderHasExistingItems(
              message: error.message,
              hasExistingItem: error.hasExistingItems,
              addNewPouchApproval: error.addNewPouchApproval,
              detailedMessage: error.detailedMessage,
            ),
          );
        } else {
          emit(ReorderErrorState(message: error.message));
        }
    }
  }

  Future<void> continueReorder(bool keepExistingItems, {bool? addNewPouch}) async {
    if (_currentOrderId != null) {
      await reorder(_currentOrderId!, continueWithExisting: keepExistingItems, addNewPouch: addNewPouch);
    }
  }
}
