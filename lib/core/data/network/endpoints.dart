class Endpoints {
  /// ** Auth
  /// Register
  static const register = "auth/register";
  static const verifyOTP = "auth/register/verify-otp";
  static String editPhoneNum(String sessionId) => "auth/register/edit-phone/$sessionId";
  static String resendOtp(String sessionId) => "auth/register/resend-otp/$sessionId";

  /// Login
}
