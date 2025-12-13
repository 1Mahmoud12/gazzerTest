import 'package:gazzer/features/search/data/search_query.dart';

class Endpoints {
  Endpoints._();

  /// ** Auth
  // Register
  static const checkPhoneEmail = 'clients/auth/check-phone-email';
  static const register = 'clients/auth/register';
  static const verifyOTP = 'clients/auth/register/verify-otp';
  static String editPhoneNum = 'clients/auth/register/edit-phone';
  static const resendOtp = 'clients/auth/register/resend-otp';

  // Login
  static const login = 'clients/auth/login';

  // profile
  static const logout = 'clients/auth/logout';
  static const refreshToken = 'clients/auth/refresh-token';
  static const profile = 'clients/auth/me';
  static const updateProfile = 'clients/edit-profile';
  static const verifyProfileUpdate = 'clients/edit-profile/verify-otp';
  static const changePassword = 'clients/change-password';

  // delete account
  static const requestDeleteAccount = 'clients/request-delete-account';
  static const confirmDeleteAccount = 'clients/confirm-delete-account';
  static const deleteAccountReasons = 'core/reasons/delete_client_account';

  // Forget password
  static const forgetPassword = 'clients/auth/forgot-password';
  static const resetPassword = 'clients/auth/reset-password';
  static const forgetPasswordVerifyOTP = 'clients/auth/forgot-password/verify-otp';

  /// ** Addresses
  static const addresses = 'clients/addresses';
  static const addAddress = 'clients/addresses';

  static String editAddress(int id) => 'clients/addresses/update/$id';

  static String deleteAddress(int id) => 'clients/addresses/$id';
  static const setDefaultAddress = 'clients/addresses/set-default';
  static const getProvinces = 'provinces';
  static String getZones(int provinceId) => 'provinces/$provinceId/zones';

  /// ** cart
  static const getCart = 'cart';
  static const getAvailableSlots = 'cart/available-slots';
  static const addToCart = 'cart/add-to-cart';
  static const removeFromCart = 'cart/remove-from-cart';
  static const updateCartItem = 'cart/update-cart-item';
  static const updateCartAddress = 'cart/set-cart-address';
  static const changeItemQnty = 'cart/change-quantity';

  static String updatecartItemNote(int id) => 'cart/update-notes/$id';

  /// ** pages
  static const homePage = 'homepage';
  static const getAllOffers = 'homepage/widget/stores-with-offers-and-items-offers';
  static const topVendors = 'homepage/widget/top-vendors';
  static const topItems = 'homepage/widget/top-items';
  static const suggests = 'homepage/widget/suggests';
  static const suggestsWidget = 'homepage/widget/suggests';
  static const bestPopularStores = 'homepage/widget/best-popular';
  static const categoriesWidget = 'homepage/widget/categories';
  static const dailyOffersWidget = 'homepage/widget/daily-offers';
  // restaurants
  static const restaurantsMenuPage = 'pages/restaurants-page';

  static String restaurantsOfCategoryPage(int id) => 'pages/restaurants-page/category/$id';
  static String restaurantPage(int id) => 'pages/restaurant-page/$id';
  // stores
  static String storesMenuPage(int mainId) => 'pages/store-category-page/$mainId';

  static String storesOfSpecificCategoryPage(int mainId, int subId) => 'pages/store-category/$mainId/item-category-page/$subId';

  static String storeDetailsPage(int id) => 'pages/store-page/$id';

  static String productDetails(int id) => 'pages/item-page/$id';

  static String search(SearchQuery query) => 'search${query.toQuery()}';

  /// ** stores categories
  static const storesCategories = 'stores/categories';

  /// ** restaurants
  static String allRestaurants(int page, int limit) => 'restaurants?is_paginated=1&page=$page&limit=$limit';

  static String retaurantsByCatOfPlate(int catId, {int pag = 0, int limit = 10}) => 'restaurants/category/$catId';

  static String topRatedRestaurants(int catId, {int pag = 0, int limit = 10}) => 'restaurants/category/$catId/top-rated';

  static String offersRestaurants(int catId, {int pag = 0, int limit = 10}) => 'restaurants/category/$catId/has-offers';

  static String todaysPicRestaurants(int catId, {int pag = 0, int limit = 10}) => 'lists/todays-picks-restaurants';

  static String orderWith(int restId, int plateId) => 'restaurants/plates/plate/$plateId/ordered-with';

  static String plateDetailsPage(int plateId) => 'restaurants/plates/plate/$plateId';

  /// ** categoryOfPlates
  static const platesCategories = 'restaurants/plates/categories';

  static String categoryOfPlatesByRest(int restId) => 'restaurants/$restId/plates/categories?is_paginated=0';

  /// ** paltes
  static String platesByRest(int restId) => 'restaurants/$restId/plates';

  static String platesOfRestaurantCategory(int restId, int catId) => 'restaurants/$restId/plates/category/$catId?is_paginated=0';

  // ** banners
  static const restaurantsMenuBanners = 'banners/restaurants-page';

  static String storeCategoryBanners(int id) => 'banners/bannerable/store-category/id/$id';

  // ** Favorites
  static const favorites = 'favorites';
  static const addFavorite = 'favorites/add';
  static const removeFavorite = 'favorites/remove';

  // ** CheckOut
  static const getCheckoutData = 'wallet';
  static const getVoucher = 'vouchers/list';
  static const orderSummary = 'orders/order-summary';
  static const checkVoucher = 'vouchers/validate';
  static const convertVoucher = 'vouchers/convert';
  static const convertPoints = 'loyalty/convert-points';
  static const addNewCard = 'wallet/cards';
  static const ordersCheckout = 'orders/checkout';

  /// ** Orders
  static const clientOrders = 'orders/client-orders';

  static String orderDetail(int id) => 'orders/order/$id';

  static String reorder(int id) => 'orders/reorder/$id';

  static String submitOrderReview(int orderId) => 'orders/review/$orderId';

  /// ** Wallet
  static const wallet = 'wallet';
  static const walletTransactions = 'wallet/transactions';
  static const addBalance = 'wallet/add-balance';

  static String voucherStores(int amount) => 'vouchers/stores/$amount';

  /// ** Loyalty Program
  static const loyaltyProgram = 'loyalty/program';

  /// ** Support / FAQ
  static const faqCategories = 'support/faqs/categories';
  static const faqRating = 'support/ratings';

  /// ** Support / Chat
  static String getChatMessages(int chatId) => 'support/chats/$chatId';
  static const sendChatMessage = 'support/chats';

  /// ** Support / Complaints
  static const submitComplaint = 'support/complaints';

  /// ** Support / Working Hours
  static const workingHours = 'support/working-hours';
}
