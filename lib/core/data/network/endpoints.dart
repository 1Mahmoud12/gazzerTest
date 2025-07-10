class Endpoints {
  /// ** Auth
  /// Register
  static const register = "clients/auth/register";
  static const verifyOTP = "clients/auth/register/verify-otp";
  static String editPhoneNum(String sessionId) => "clients/auth/register/edit-phone/$sessionId";
  static String resendOtp(String sessionId) => "clients/auth/register/resend-otp/$sessionId";

  /// Login
  static const login = "clients/auth/login";

  /// Forget password
  static const forgetPassword = "clients/auth/forgot-password";
  static const resetPassword = "clients/auth/reset-password";
  static const forgetPasswordVerifyOTP = "clients/auth/forgot-password/verify-otp";

  /// stores categories
  static const storesCategories = "stores/categories";
  static String subcategory(int catId) => "stores/sub-categories/$catId";

  // restaurants
  static String retaurantsByCat(int catId) => "restaurants/category/$catId";
  static String retaurantsBySubCat(int subcatIt) => "restaurants/sub-category/$subcatIt";
  static String retaurantsByCatAnSubCat(int catId, int subCatId) => "restaurants/category/$catId/sub-category/$subCatId";
}
