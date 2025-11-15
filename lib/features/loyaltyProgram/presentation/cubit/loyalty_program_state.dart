import 'package:equatable/equatable.dart';
import 'package:gazzer/features/loyaltyProgram/domain/entities/loyalty_program_entity.dart';

sealed class LoyaltyProgramState extends Equatable {
  const LoyaltyProgramState();

  @override
  List<Object?> get props => [];
}

class LoyaltyProgramInitial extends LoyaltyProgramState {
  const LoyaltyProgramInitial();
}

class LoyaltyProgramLoading extends LoyaltyProgramState {
  const LoyaltyProgramLoading({this.isInitial = false});

  final bool isInitial;

  @override
  List<Object?> get props => [isInitial];
}

class LoyaltyProgramLoaded extends LoyaltyProgramState {
  const LoyaltyProgramLoaded({
    required this.data,
    this.isCached = false,
  });

  final LoyaltyProgramEntity data;
  final bool isCached;

  @override
  List<Object?> get props => [data, isCached];
}

class LoyaltyProgramError extends LoyaltyProgramState {
  const LoyaltyProgramError({
    required this.message,
    this.cachedData,
  });

  final String message;
  final LoyaltyProgramEntity? cachedData;

  @override
  List<Object?> get props => [message, cachedData];
}
