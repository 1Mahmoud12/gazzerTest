import 'package:equatable/equatable.dart';

sealed class ReorderState extends Equatable {
  const ReorderState();

  @override
  List<Object?> get props => [];
}

class ReorderInitial extends ReorderState {
  const ReorderInitial();
}

class ReorderLoading extends ReorderState {
  const ReorderLoading({required this.orderId});

  final int orderId;

  @override
  List<Object?> get props => [orderId];
}

class ReorderSuccess extends ReorderState {
  const ReorderSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ReorderErrorState extends ReorderState {
  const ReorderErrorState({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class ReorderHasExistingItems extends ReorderState {
  const ReorderHasExistingItems({
    required this.message,
    required this.existingItemsCount,
    this.detailedMessage,
  });

  final String message;
  final int existingItemsCount;
  final String? detailedMessage;

  @override
  List<Object?> get props => [message, existingItemsCount, detailedMessage];
}
