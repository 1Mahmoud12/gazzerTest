class Endpoints {
  /// ** Auth
  // Register
  static const register = "clients/auth/register";
  static const verifyOTP = "clients/auth/register/verify-otp";
  static String editPhoneNum = "clients/auth/register/edit-phone";
  static const resendOtp = "clients/auth/register/resend-otp";

  // Login
  static const login = "clients/auth/login";

  // profile
  static const logout = "clients/auth/logout";
  static const refreshToken = "clients/auth/refresh-token";
  static const profile = "clients/auth/me";
  static const updateProfile = "clients/edit-profile";
  static const verifyProfileUpdate = "clients/edit-profile/verify-otp";
  static const changePassword = "clients/change-password";

  // delete account
  static const requestDeleteAccount = "clients/request-delete-account";
  static const confirmDeleteAccount = "clients/confirm-delete-account";
  static const deleteAccountReasons = "core/reasons/delete_client_account";

  // Forget password
  static const forgetPassword = "clients/auth/forgot-password";
  static const resetPassword = "clients/auth/reset-password";
  static const forgetPasswordVerifyOTP = "clients/auth/forgot-password/verify-otp";

  /// ** Addresses
  static const addresses = "clients/addresses";
  static const addAddress = "clients/addresses";
  static String editAddress(int id) => "clients/addresses/update/$id";
  static String deleteAddress(int id) => "clients/addresses/$id";
  static const setDefaultAddress = "clients/addresses/set-default";

  /// ** pages
  static const homePage = "homepage";

  /// ** stores categories
  static const storesCategories = "stores/categories";

  /// ** restaurants
  static String allRestaurants(int page, int limit) => "restaurants?is_paginated=1&page=$page&limit=$limit";
  static String retaurantsByCatOfPlate(int catId, {int pag = 0, int limit = 10}) => "restaurants/category/$catId";

  /// ** categoryOfPlates
  static const platesCategories = 'restaurants/plates/categories';
  static String categoryOfPlatesByRest(int restId) => "restaurants/$restId/plates/categories?is_paginated=0";

  /// ** paltes
  static String platesByRest(int restId) => "restaurants/$restId/plates";
  static String platesByRestAnCatOfPlate(int restId, int catId) => "restaurants/$restId/plates/$catId";

  // ** banners
  static const restaurantsMenuBanners = "banners/restaurants-page";
  static String storeCategoryBanners(int id) => "banners/bannerable/store-category/id/$id";
}
