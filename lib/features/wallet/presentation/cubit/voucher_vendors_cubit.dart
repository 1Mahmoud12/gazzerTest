import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/wallet/domain/entities/voucher_store_entity.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/features/wallet/presentation/cubit/voucher_vendors_state.dart';

class VoucherVendorsCubit extends Cubit<VoucherVendorsState> {
  VoucherVendorsCubit(this._repo) : super(const VoucherVendorsInitial());

  final WalletRepo _repo;

  Future<void> loadVoucherStores(int amount) async {
    emit(const VoucherVendorsLoading());

    final result = await _repo.getVoucherStores(amount);
    switch (result) {
      case Ok<List<VoucherStoreEntity>>(:final value):
        emit(VoucherVendorsLoaded(stores: value));
      case Err<List<VoucherStoreEntity>>(:final error):
        emit(VoucherVendorsError(message: error.message));
    }
  }

  Future<void> convertVoucher(String voucherCode) async {
    final currentState = state;
    if (currentState is! VoucherVendorsLoaded) return;

    emit(VoucherVendorsConverting(stores: currentState.stores));

    final result = await _repo.convertVoucher(voucherCode);
    switch (result) {
      case Ok<String>(:final value):
        emit(
          VoucherVendorsConvertSuccess(
            stores: currentState.stores,
            message: value,
          ),
        );
      case Err<String>(:final error):
        emit(
          VoucherVendorsConvertError(
            stores: currentState.stores,
            message: error.message,
          ),
        );
    }
  }

  Future<void> convertMultipleVouchers(List<String> voucherCodes) async {
    final currentState = state;
    if (currentState is! VoucherVendorsLoaded) return;

    emit(VoucherVendorsConverting(stores: currentState.stores));

    final List<String> successMessages = [];
    final List<String> errorMessages = [];

    for (final voucherCode in voucherCodes) {
      final result = await _repo.convertVoucher(voucherCode);
      switch (result) {
        case Ok<String>(:final value):
          successMessages.add(value);
        case Err<String>(:final error):
          errorMessages.add(error.message);
      }
    }

    if (errorMessages.isEmpty) {
      final message = successMessages.isNotEmpty
          ? successMessages.first
          : 'All vouchers converted successfully';
      emit(
        VoucherVendorsConvertSuccess(
          stores: currentState.stores,
          message: message,
        ),
      );
    } else {
      final message = errorMessages.join(', ');
      emit(
        VoucherVendorsConvertError(
          stores: currentState.stores,
          message: message,
        ),
      );
    }
  }
}
