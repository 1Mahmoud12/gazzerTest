import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/wallet/domain/entities/wallet_entity.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/features/wallet/presentation/cubit/wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._repo) : super(const WalletInitial());

  final WalletRepo _repo;
  WalletEntity? _cached;

  Future<void> load({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      emit(const WalletLoading(isInitial: true));
      final cached = await _repo.getCachedWallet();
      if (cached != null) {
        _cached = cached;
        emit(WalletLoaded(data: cached, isCached: true));
        if (!forceRefresh) {
          // Proceed to refresh data in background
        }
      }
    } else {
      emit(const WalletLoading());
    }

    final result = await _repo.getWallet();
    switch (result) {
      case Ok<WalletEntity?>(:final value):
        if (value != null) {
          _cached = value;
          emit(WalletLoaded(data: value));
        } else {
          emit(
            WalletError(
              message: 'Unable to load wallet data',
              cachedData: _cached,
            ),
          );
        }
      case Err<WalletEntity?>(:final error):
        emit(WalletError(message: error.message, cachedData: _cached));
    }
  }
}
