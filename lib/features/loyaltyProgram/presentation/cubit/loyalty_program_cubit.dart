import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/core/data/network/result_model.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';
import 'package:gazzer/features/loyaltyProgram/domain/loyalty_program_repo.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/cubit/loyalty_program_state.dart';

class LoyaltyProgramCubit extends Cubit<LoyaltyProgramState> {
  LoyaltyProgramCubit(this._repo) : super(const LoyaltyProgramInitial());

  final LoyaltyProgramRepo _repo;
  LoyaltyProgramEntity? _cached;

  Future<void> load({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      emit(const LoyaltyProgramLoading(isInitial: true));
      final cached = await _repo.getCachedLoyaltyProgram();
      if (cached != null) {
        _cached = cached;
        emit(LoyaltyProgramLoaded(data: cached, isCached: true));
        if (!forceRefresh) {
          // Proceed to refresh data in background
        }
      }
    } else {
      emit(const LoyaltyProgramLoading());
    }

    final result = await _repo.getLoyaltyProgram();
    switch (result) {
      case Ok<LoyaltyProgramEntity?>(:final value):
        if (value != null) {
          _cached = value;
          emit(LoyaltyProgramLoaded(data: value));
        } else {
          emit(
            LoyaltyProgramError(
              message: 'Unable to load loyalty program data',
              cachedData: _cached,
            ),
          );
        }
      case Err<LoyaltyProgramEntity?>(:final error):
        emit(LoyaltyProgramError(message: error.message, cachedData: _cached));
    }
  }
}
