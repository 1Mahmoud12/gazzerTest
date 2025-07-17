import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/checkout/presentation/view/confirm_order.dart';
import 'package:gazzer/features/checkout/presentation/view/post_checkout_screen.dart';
import 'package:go_router/go_router.dart';

final checkoutRoutes = [
  GoRoute(
    path: CartScreen.route,
    builder: (context, state) => const CartScreen(),
  ),
  GoRoute(
    path: ConfirmOrderScreen.route,
    builder: (context, state) => const ConfirmOrderScreen(),
  ),
  GoRoute(
    path: PostCheckoutScreen.route,
    builder: (context, state) => const PostCheckoutScreen(),
  ),
];
