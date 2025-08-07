import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_states.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
}
