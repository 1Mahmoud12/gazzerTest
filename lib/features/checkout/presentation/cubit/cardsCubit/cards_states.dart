import 'package:equatable/equatable.dart';

sealed class CardsStates extends Equatable {
  const CardsStates();

  @override
  List<Object?> get props => [];
}

class CardsInitial extends CardsStates {}

class CardsLoading extends CardsStates {}

class CardAddedSuccess extends CardsStates {
  const CardAddedSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class CardAddedError extends CardsStates {
  const CardAddedError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
