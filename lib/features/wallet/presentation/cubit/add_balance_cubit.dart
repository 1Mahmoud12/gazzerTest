import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/pkgs/dialog_loading_animation.dart';
import 'package:gazzer/features/wallet/domain/entities/add_balance_entity.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/features/wallet/presentation/cubit/add_balance_state.dart';
import 'package:gazzer/features/wallet/presentation/views/widgets/payment_method_bottom_sheet.dart';

class AddBalanceCubit extends Cubit<AddBalanceState> {
  AddBalanceCubit(this._walletRepo) : super(const AddBalanceInitial());

  final WalletRepo _walletRepo;

  String _paymentMethodToString(PaymentMethodType type) {
    switch (type) {
      case PaymentMethodType.creditDebit:
        return 'pay_by_card';
      case PaymentMethodType.eWallet:
        return 'e_wallet';
      case PaymentMethodType.applePay:
        return 'apple_pay';
    }
  }

  Future<void> addBalance({
    required double amount,
    required String description,
    required PaymentMethodType paymentMethodType,
    String? phone,
    int? cardId,
  }) async {
    emit(const AddBalanceLoading());
    animationDialogLoading();

    final paymentMethod = _paymentMethodToString(paymentMethodType);

    final result = await _walletRepo.addBalance(
      amount: amount,
      description: description,
      paymentMethod: paymentMethod,
      phone: phone,
      cardId: cardId,
    );
    closeDialog();
    switch (result) {
      case Ok<AddBalanceResponse?>(:final value):
        if (value != null &&
            value.iframeUrl != null &&
            value.iframeUrl!.isNotEmpty) {
          emit(AddBalanceSuccess(value.iframeUrl!));
        } else {
          emit(const AddBalanceError('No payment URL provided'));
        }
      case Err<AddBalanceResponse?>(:final error):
        emit(AddBalanceError(error.message));
    }
  }
}
