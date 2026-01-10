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
import 'package:gazzer/features/cart/presentation/views/select_address_screen.dart';
import 'package:gazzer/features/checkout/presentation/view/confirm_order.dart';
import 'package:gazzer/features/checkout/presentation/view/post_checkout_screen.dart';
import 'package:gazzer/features/home/homeViewAll/topItems/presentation/view/popular_screen.dart';
import 'package:gazzer/features/home/homeViewAll/top_vendors/presentation/top_vendors_screen.dart';
import 'package:gazzer/features/home/main_home/presentaion/view/widgets/all_categories_screen.dart';
import 'package:gazzer/features/intro/presentation/congrats_screen.dart';
import 'package:gazzer/features/intro/presentation/loading_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/diatery_lifestyle_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/frequancy_combos_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/health_focus_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/nuttration_support_screen.dart';
import 'package:gazzer/features/intro/presentation/plan/views/supplements_screen.dart';
import 'package:gazzer/features/intro/presentation/tutorial/view/intro_video_tutorial_screen.dart';
import 'package:gazzer/features/loyaltyProgram/presentation/views/loyalty_program_hero_one.dart';
import 'package:gazzer/features/orders/views/order_details_screen.dart';
import 'package:gazzer/features/orders/views/track_order_screen.dart';
import 'package:gazzer/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:gazzer/features/profile/presentation/views/delete_account_screen.dart';
import 'package:gazzer/features/profile/presentation/views/saved_cards_screen.dart';
import 'package:gazzer/features/profile/presentation/views/update_password_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/gazzer_support_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/order_issue_response_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/order_issue_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/ordersIssueScreens/incorrect_items_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/ordersIssueScreens/missing_items_screen.dart';
import 'package:gazzer/features/supportScreen/presentation/views/support_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/plate_details/views/plate_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/multi_cat_restaurant/presentation/view/multi_cat_restaurant_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/restaurant_details_screen.dart';
import 'package:gazzer/features/vendors/resturants/presentation/single_restaurant/single_cat_restaurant/view/single_cat_restaurant_details.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/product_details/views/product_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/grocery/store_Details/views/store_details_screen.dart';
import 'package:gazzer/features/vendors/stores/presentation/pharmacy/store/pharmacy_store_screen.dart';
import 'package:gazzer/features/wallet/presentation/views/wallet_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
  $restaurantDetilsRoute,
  $singleCatRestaurantRoute,
  $multiCatRestaurantsRoute,
  // stores
  $storeDetailsRoute,
  $pharmacyStoreScreenRoute,

  /// scattered;
  $deleteAccountRoute,
  $addEditAddressRoute,
  $selectLocationRoute,

  // home categories
  GoRoute(
    path: TopVendorsScreen.route,
    builder: (context, state) {
      return const TopVendorsScreen();
    },
  ),

  GoRoute(
    path: PopularScreen.route,
    builder: (context, state) {
      return const PopularScreen();
    },
  ),
  GoRoute(
    path: AllCategoriesScreen.route,
    builder: (context, state) {
      return const AllCategoriesScreen();
    },
  ),
  GoRoute(
    path: LoyaltyProgramHeroOneScreen.route,
    builder: (context, state) {
      return const LoyaltyProgramHeroOneScreen();
    },
  ),

  GoRoute(
    path: WalletScreen.route,
    builder: (context, state) {
      return const WalletScreen();
    },
  ),

  GoRoute(
    path: SavedCardsScreen.route,
    builder: (context, state) {
      return const SavedCardsScreen();
    },
  ),

  GoRoute(
    path: SupportScreen.route,
    builder: (context, state) {
      return const SupportScreen();
    },
  ),
  GoRoute(
    path: OrderIssueScreen.route,
    builder: (context, state) {
      return OrderIssueScreen(orderId: state.extra as int?);
    },
  ),
  GoRoute(
    path: UpodatePasswordScreen.fullRoute,
    builder: (context, state) {
      final cubit = state.extra as ProfileCubit?;
      if (cubit != null) {
        return BlocProvider.value(
          value: cubit,
          child: const UpodatePasswordScreen(),
        );
      }
      // If no cubit provided, create a new one (fallback)
      return BlocProvider(
        create: (context) => di<ProfileCubit>(),
        child: const UpodatePasswordScreen(),
      );
    },
  ),
  GoRoute(
    path: MissingItemsScreen.route,
    builder: (context, state) {
      return MissingItemsScreen(orderId: state.extra! as int);
    },
  ),
  GoRoute(
    path: IncorrectItemsScreen.route,
    builder: (context, state) {
      if (state.extra is Map<String, dynamic>) {
        final extra = state.extra! as Map<String, dynamic>;
        return IncorrectItemsScreen(
          orderId: extra['orderId'] as int,
          faqCategoryId: extra['faqCategoryId'] as int?,
        );
      }
      return IncorrectItemsScreen(orderId: state.extra! as int);
    },
  ),
  GoRoute(
    path: OrderIssueResponseScreen.route,
    builder: (context, state) {
      return const OrderIssueResponseScreen();
    },
  ),
  GoRoute(
    path: GazzerSupportScreen.route,
    builder: (context, state) {
      return GazzerSupportScreen(orderId: state.extra as int?);
    },
  ),
  GoRoute(
    path: OrderDetailsScreen.route,
    builder: (context, state) {
      return OrderDetailsScreen(orderId: state.extra! as int);
    },
  ),
  GoRoute(
    path: TrackOrderScreen.route,
    builder: (context, state) {
      if (state.extra is Map<String, dynamic>) {
        final extra = state.extra! as Map<String, dynamic>;
        return TrackOrderScreen(
          orderId: extra['orderId'] as int,
          deliveryTimeMinutes: extra['deliveryTimeMinutes'] as int?,
          userLocation: extra['userLocation'] as LatLng?,
          deliveryLocation: extra['deliveryLocation'] as LatLng?,
          roadDistance: extra['roadDistance'] as double?,
          deliveryManName: extra['deliveryManName'] as String?,
        );
      }
      return TrackOrderScreen(orderId: state.extra as int? ?? 0);
    },
  ),
];

final checkoutRoutes = [
  GoRoute(
    path: SelectAddressScreen.route,
    builder: (context, state) => const SelectAddressScreen(),
  ),
  GoRoute(
    path: ConfirmOrderScreen.route,
    builder: (context, state) => const ConfirmOrderScreen(),
  ),
  // GoRoute(
  //   path: CardDetailsScreen.route,
  //   builder: (context, state) => const CardDetailsScreen(),
  // ),
  GoRoute(
    path: PostCheckoutScreen.route,
    builder: (context, state) => const PostCheckoutScreen(),
  ),
];

final planScreens = [
  GoRoute(
    path: HealthFocusScreen.route,
    builder: (context, state) => const HealthFocusScreen(),
  ),
  GoRoute(
    path: DiateryLifestyleScreen.route,
    builder: (context, state) => const DiateryLifestyleScreen(),
  ),
  GoRoute(
    path: SupplementsScreen.route,
    builder: (context, state) => const SupplementsScreen(),
  ),
  GoRoute(
    path: NuttrationSupportScreen.route,
    builder: (context, state) => const NuttrationSupportScreen(),
  ),
  GoRoute(
    path: FrequancyCombosScreen.route,
    builder: (context, state) => const FrequancyCombosScreen(),
  ),
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
