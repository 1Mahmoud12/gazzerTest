class Endpoints {
  /// ** Auth
  // Register
  static const register = "clients/auth/register";
  static const verifyOTP = "clients/auth/register/verify-otp";
  static String editPhoneNum(String sessionId) => "clients/auth/register/edit-phone/$sessionId";
  static String resendOtp(String sessionId) => "clients/auth/register/resend-otp/$sessionId";

  // Login
  static const login = "clients/auth/login";

  // Forget password
  static const forgetPassword = "clients/auth/forgot-password";
  static const resetPassword = "clients/auth/reset-password";
  static const forgetPasswordVerifyOTP = "clients/auth/forgot-password/verify-otp";

  /// ** pages
  static const homePage = "homepage";

  /// ** stores categories
  static const storesCategories = "stores/categories";

  /// ** restaurants
  static String allRestaurants(int page, int limit) => "restaurants?is_paginated=1&page=$page&limit=$limit";
  static String retaurantsByCatOfPlate(int catId) => "restaurants/category/$catId?is_paginated=0";

  /// ** categoryOfPlates
  static const categoriesOfPlates = 'restaurants/plates/sub-categories?is_paginated=0';
  static String categoryOfPlatesByRest(int restId) => "restaurants/$restId/plates/categories?is_paginated=0";

  /// ** paltes
  static String platesByRest(int restId) => "restaurants/$restId/plates";
  static String platesByRestAnCatOfPlate(int restId, int catId) => "restaurants/$restId/plates/$catId";
}
