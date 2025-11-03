import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/core/presentation/views/widgets/helper_widgets/alerts.dart';
import 'package:gazzer/features/checkout/data/dtos/checkout_data_dto.dart';
import 'package:gazzer/features/checkout/domain/checkout_repo.dart';
import 'package:gazzer/features/checkout/presentation/cubit/vouchers_states.dart';

class VouchersCubit extends Cubit<VouchersStates> {
  VouchersCubit(this._checkoutRepo) : super(VouchersInitial()) {
    loadVouchers();
  }

  final CheckoutRepo _checkoutRepo;

  // Vouchers list from API
  final List<VoucherDTO> _voucherList = [];

  List<String> get vouchers => _voucherList.map((e) => e.code).toList();

  /// Toggles text field enabled/disabled state for VoucherWidget
  bool isTextFieldEnabled = false;

  void toggleTextField() {
    isTextFieldEnabled = !isTextFieldEnabled;
    emit(VoucherChange(timestamp: DateTime.now().millisecondsSinceEpoch));
  }

  /// Fetch vouchers from API
  Future<void> loadVouchers() async {
    final result = await _checkoutRepo.getVouchers();
    switch (result) {
      case Ok<List<VoucherDTO>>(:final value):
        _voucherList
          ..clear()
          ..addAll(value);
        emit(VoucherChange(timestamp: DateTime.now().millisecondsSinceEpoch));
      case Err(:final error):
        Alerts.showToast(error.message);
    }
  }

  /// Applies a voucher code against backend validation
  Future<void> applyVoucher(String code) async {
    emit(VoucherLoading());

    final result = await _checkoutRepo.checkVoucher(code.trim());
    switch (result) {
      case Ok<VoucherDTO>(:final value):
        final discount = double.tryParse(value.discountValue) ?? 0.0;
        emit(VoucherApplied(voucherCode: value.code, discountAmount: discount, discountType: value.discountType));
      case Err(:final error):
        emit(VoucherError(message: error.message.isEmpty ? L10n.tr().invalidVoucherCode : error.message));
    }
  }
}
