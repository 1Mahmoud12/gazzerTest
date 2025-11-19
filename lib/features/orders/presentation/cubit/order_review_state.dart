import 'package:equatable/equatable.dart';

sealed class OrderReviewState extends Equatable {
  const OrderReviewState();

  @override
  List<Object?> get props => [];
}

class OrderReviewInitial extends OrderReviewState {
  const OrderReviewInitial();
}

class OrderReviewLoading extends OrderReviewState {
  const OrderReviewLoading();
}

class OrderReviewSuccess extends OrderReviewState {
  const OrderReviewSuccess({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class OrderReviewError extends OrderReviewState {
  const OrderReviewError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
