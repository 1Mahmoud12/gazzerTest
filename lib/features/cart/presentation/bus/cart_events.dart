import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';
import 'package:gazzer/features/cart/domain/entities/cart_item_entity.dart';
import 'package:gazzer/features/cart/presentation/bus/item_fast_actions_state.dart';

sealed class GetCartEvents extends AppEvent {
  final CartResponse data;

  GetCartEvents({required this.data});
}

class GetCartLoading extends GetCartEvents {
  GetCartLoading() : super(data: Fakers.cartResponse);
}

class GetCartLoaded extends GetCartEvents {
  GetCartLoaded({required super.data});
}

class GetCartError extends GetCartEvents {
  final String? error;
  GetCartError(this.error) : super(data: Fakers.cartResponse);
}

///
sealed class FastItemEvents extends AppEvent {
  final int prodId;
  final ItemFastActionState state;
  final List<CartItemEntity> items;

  FastItemEvents({required this.prodId, this.state = const ItemFastActionState(), required this.items});
}

class FastItemActionsLoading extends FastItemEvents {
  FastItemActionsLoading({required super.state, required super.items, required super.prodId});
}

class FastItemActionsLoaded extends FastItemEvents {
  FastItemActionsLoaded({required super.items, required super.prodId});
}

class FastItemActionsError extends FastItemEvents {
  final String? message;

  FastItemActionsError(this.message, {required super.items, required super.prodId});
}
