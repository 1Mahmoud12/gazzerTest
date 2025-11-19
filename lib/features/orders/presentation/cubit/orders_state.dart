import 'package:equatable/equatable.dart';
import 'package:gazzer/features/orders/domain/entities/order_item_entity.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object?> get props => [];
}

class OrdersInitial extends OrdersState {
  const OrdersInitial();
}

class OrdersLoading extends OrdersState {
  const OrdersLoading({this.orders = const [], this.hasMore = false});

  final List<OrderItemEntity> orders;
  final bool hasMore;

  @override
  List<Object?> get props => [orders, hasMore];
}

class OrdersLoaded extends OrdersState {
  const OrdersLoaded({
    required this.orders,
    this.hasMore = false,
    this.currentPage = 1,
  });

  final List<OrderItemEntity> orders;
  final bool hasMore;
  final int currentPage;

  @override
  List<Object?> get props => [orders, hasMore, currentPage];
}

class OrdersError extends OrdersState {
  const OrdersError({required this.message, this.orders = const []});

  final String message;
  final List<OrderItemEntity> orders;

  @override
  List<Object?> get props => [message, orders];
}
