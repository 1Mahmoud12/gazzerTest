import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';

class CartEvents extends AppEvent {
  final CartResponse data;
  CartEvents({required this.data});
}

///
sealed class GetCartEvents extends CartEvents {
  GetCartEvents({required super.data});
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
sealed class UpdateCartItems extends CartEvents {
  final int cartId;
  UpdateCartItems({required super.data, required this.cartId});
}

class UpdateCartItemsLoading extends UpdateCartItems {
  UpdateCartItemsLoading({required super.cartId, required super.data});
}

class UpdateCartItemsLoaded extends UpdateCartItems {
  UpdateCartItemsLoaded({required super.data, required super.cartId});
}

class UpdateCartItemsError extends UpdateCartItems {
  final String? message;
  UpdateCartItemsError(this.message, {required super.cartId}) : super(data: Fakers.cartResponse);
}

///
sealed class GetTimeSlots extends AppEvent {
  final List<String> slots;
  GetTimeSlots({required this.slots});
}

class GetTimeSlotsLoading extends GetTimeSlots {
  GetTimeSlotsLoading() : super(slots: []);
}

class GetTimeSlotsLoaded extends GetTimeSlots {
  GetTimeSlotsLoaded({required super.slots});
}

class GetTimeSlotsError extends GetTimeSlots {
  final String? message;
  GetTimeSlotsError(this.message) : super(slots: []);
}
