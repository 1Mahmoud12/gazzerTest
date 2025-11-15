import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/core/presentation/localization/l10n.dart';
import 'package:gazzer/features/wallet/domain/wallet_repo.dart';
import 'package:gazzer/features/wallet/presentation/cubit/convert_points_state.dart';

class ConvertPointsCubit extends Cubit<ConvertPointsState> {
  ConvertPointsCubit(this._repo) : super(const ConvertPointsInitial());

  final WalletRepo _repo;

  Future<void> convertPoints(int points) async {
    if (points <= 0) {
      emit(ConvertPointsError(message: L10n.tr().cantConvertLessZanZero));
      return;
    }

    emit(const ConvertPointsLoading());

    final result = await _repo.convertPoints(points);
    switch (result) {
      case Ok<String>(:final value):
        emit(ConvertPointsSuccess(message: value));
      case Err<String>(:final error):
        emit(ConvertPointsError(message: error.message));
    }
  }
}
