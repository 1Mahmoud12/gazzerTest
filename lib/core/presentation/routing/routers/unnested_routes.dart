import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gazzer/di.dart';
import 'package:gazzer/features/addresses/presentation/views/add_edit_address_screen.dart';
import 'package:gazzer/features/auth/common/widgets/select_location_screen.dart';
import 'package:gazzer/features/auth/forgot_password/presentation/reset_password_screen.dart';
import 'package:gazzer/features/auth/login/presentation/login_screen.dart';
import 'package:gazzer/features/auth/register/presentation/view/create_password_screen.dart';
import 'package:gazzer/features/auth/register/presentation/view/register_screen.dart';
import 'package:gazzer/features/auth/verify/presentation/verify_otp_screen.dart';
import 'package:gazzer/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:gazzer/features/cart/presentation/views/cart_screen.dart';
import 'package:gazzer/features/cart/presentation/views/select_address_screen.dart';
import 'package:gazzer/features/checkout/presentation/view/confirm_order.dart';
import 'package:gazzer/features/checkout/presentation/view/post_checkout_screen.dart';
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/diatery_lifestyle_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/frequancy_combos_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/nuttration_support_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/supplements_screen.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';
import 'package:gazzer/features/profile/presentation/views/delete_account_screen.dart';
import 'package:gazzer/features/search/presentaion/view/search_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_cat_restaurant_details.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> unNestedRoutes = [
  ...authRoutes,
  ...checkoutRoutes,
  ...planScreens,
  $plateDetailsRoute,
  $productDetailsRoute,

  /// plan & intro
  $congratsScreenRoute,
  $loadingScreenRoute,
  $introVideoTutorialRoute,

  // restaurants
  $singleCatRestaurantRoute,

  /// scattered;
  $deleteAccountRoute,
  $addEditAddressRoute,
  $selectLocationRoute,
  GoRoute(
    path: SearchScreen.route,
    builder: (context, state) => const SearchScreen(),
  ),
];

final checkoutRoutes = [
  GoRoute(
    path: CartScreen.route,
    builder: (context, state) => BlocProvider(create: (context) => di<CartCubit>(), child: const CartScreen()),
  ),

  GoRoute(
    path: SelectAddressScreen.route,
    builder: (context, state) => const SelectAddressScreen(),
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

final planScreens = [
  GoRoute(path: HealthFocusScreen.route, builder: (context, state) => const HealthFocusScreen()),
  GoRoute(path: DiateryLifestyleScreen.route, builder: (context, state) => const DiateryLifestyleScreen()),
  GoRoute(path: SupplementsScreen.route, builder: (context, state) => const SupplementsScreen()),
  GoRoute(path: NuttrationSupportScreen.route, builder: (context, state) => const NuttrationSupportScreen()),
  GoRoute(path: FrequancyCombosScreen.route, builder: (context, state) => const FrequancyCombosScreen()),
];

final authRoutes = [
  GoRoute(
    path: LoginScreen.route,
    pageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    ),
  ),
  GoRoute(
    path: RegisterScreen.route,
    builder: (context, state) => const RegisterScreen(),
  ),
  GoRoute(
    path: ResetPasswordScreen.route,
    builder: (context, state) => const ResetPasswordScreen(),
  ),
  $createPasswordRoute,
  $verifyOTPScreenRoute,
];
