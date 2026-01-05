import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/checkout/domain/checkout_repo.dart';
import 'package:gazzer/features/checkout/presentation/cubit/cardsCubit/cards_states.dart';

class CardsCubit extends Cubit<CardsStates> {
  CardsCubit(this._repo) : super(CardsInitial());

  final CheckoutRepo _repo;

  Future<void> addCard({
    required String cardNumber,
    required String cardholderName,
    required String expiryMonth,
    required String expiryYear,
    required bool isDefault,
  }) async {
    emit(CardsLoading());
    final result = await _repo.addCard(
      cardNumber: cardNumber,
      cardholderName: cardholderName,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
      isDefault: isDefault,
    );
    switch (result) {
      case Ok<String>(:final value):
        Alerts.showToast(value, error: false);
        emit(CardAddedSuccess(message: value));
      case Err(:final error):
        Alerts.showToast(error.message);
        emit(CardAddedError(message: error.message));
    }
  }

  Future<void> deleteCard(int cardId) async {
    emit(CardsLoading());
    final result = await _repo.deleteCard(cardId);
    switch (result) {
      case Ok<String>(:final value):
        Alerts.showToast(value, error: false);
        emit(CardDeletedSuccess(message: value));
      case Err(:final error):
        Alerts.showToast(error.message);
        emit(CardDeletedError(message: error.message));
    }
  }
}
