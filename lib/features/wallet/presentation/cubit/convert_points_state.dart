import 'package:equatable/equatable.dart';

sealed class ConvertPointsState extends Equatable {
  const ConvertPointsState();

  @override
  List<Object?> get props => [];
}

class ConvertPointsInitial extends ConvertPointsState {
  const ConvertPointsInitial();
}

class ConvertPointsLoading extends ConvertPointsState {
  const ConvertPointsLoading();
}

class ConvertPointsSuccess extends ConvertPointsState {
  const ConvertPointsSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ConvertPointsError extends ConvertPointsState {
  const ConvertPointsError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
