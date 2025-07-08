class ForgetPasswordData {
  // Phone numbers for testing
  final String phone = "1234567890";
  final String invalidPhone = "1234567899";
  final String unregisteredPhone = "9876543210";
  final String newPhone = "5555555555";

  // OTP codes for testing
  final String validOtp = "123456";
  final String invalidOtp = "999999";
  final String expiredOtp = "000000";
  final String maxAttempteddOtp = "111111";

  // Passwords for testing
  final String newPassword = "NewPassword123!";
  final String weakPassword = "123";

  // Reset tokens for testing
  final String resetToken = "reset_token_123456789abcdef";
  final String invalidResetToken = "invalid_token";
  final String expiredResetToken = "expired_token_123";

  /// JSON responses for forgot password request
  final forgotPasswordSuccessJson = {
    "data": {},
    "message": "OTP sent successfully to your phone number",
    "status": "success",
  };

  final forgetPasswordErrorJson = {
    "message": "Failed to send OTP. Please try again.",
    "status": "error",
  };

  final phoneNotFoundErrorJson = {
    "message": "Phone number not found in our records",
    "status": "error",
  };

  /// JSON responses for verify OTP request
  final verifyOtpSuccessJson = {
    "data": {
      "reset_password_token": "reset_token_123456789abcdef",
    },
    "message": "OTP verified successfully",
    "status": "success",
  };

  final verifyOtpErrorJson = {
    "message": "Invalid OTP code. Please try again.",
    "status": "error",
  };

  final expiredOtpErrorJson = {
    "message": "OTP has expired. Please request a new one.",
    "status": "error",
  };

  final maxAttemptsReachedErrorJson = {
    "message": "Maximum OTP attempts reached. Please try again later.",
    "status": "error",
  };

  /// JSON responses for reset password request
  final resetPasswordSuccessJson = {
    "data": {},
    "message": "Password reset successfully",
    "status": "success",
  };

  final weakPasswordErrorJson = {
    "message": "The password must be at least 8 characters and contain uppercase, lowercase, number and special character.",
    "errors": {
      "password": [
        "The password must be at least 8 characters.",
        "The password must contain at least one uppercase character.",
        "The password must contain at least one number.",
        "The password must contain at least one special character.",
      ],
    },
    "status": "error",
  };

  final invalidTokenErrorJson = {
    "message": "Invalid reset password token",
    "status": "error",
  };

  final expiredTokenErrorJson = {
    "message": "Reset password token has expired. Please request a new one.",
    "status": "error",
  };

  /// JSON responses for resend OTP request
  final resendOtpSuccessJson = {
    "data": {},
    "message": "OTP sent successfully to your phone number",
    "status": "success",
  };
}
