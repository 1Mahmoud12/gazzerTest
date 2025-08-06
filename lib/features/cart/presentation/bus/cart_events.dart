import 'package:gazzer/core/data/resources/fakers.dart';
import 'package:gazzer/core/domain/app_bus.dart';
import 'package:gazzer/features/cart/data/dtos/cart_response.dart';

class CartEvents extends AppEvent {}

///
sealed class GetCartEvents extends CartEvents {
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
sealed class AddCartItemEvents extends CartEvents {
  final String? message;
  AddCartItemEvents({this.message});
}

class AddCartItemLoading extends AddCartItemEvents {}

class AddCartItemLoaded extends AddCartItemEvents {
  AddCartItemLoaded({required super.message});
}

class AddCartItemError extends AddCartItemEvents {
  AddCartItemError({required super.message});
}
