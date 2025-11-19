import 'package:equatable/equatable.dart';
import 'package:gazzer/features/orders/domain/entities/order_detail_entity.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object?> get props => [];
}

class OrderDetailInitial extends OrderDetailState {
  const OrderDetailInitial();
}

class OrderDetailLoading extends OrderDetailState {
  const OrderDetailLoading({this.orderDetail});

  final OrderDetailEntity? orderDetail;

  @override
  List<Object?> get props => [orderDetail];
}

class OrderDetailLoaded extends OrderDetailState {
  const OrderDetailLoaded({required this.orderDetail});

  final OrderDetailEntity orderDetail;

  @override
  List<Object?> get props => [orderDetail];
}

class OrderDetailError extends OrderDetailState {
  const OrderDetailError({required this.message, this.orderDetail});

  final String message;
  final OrderDetailEntity? orderDetail;

  @override
  List<Object?> get props => [message, orderDetail];
}
