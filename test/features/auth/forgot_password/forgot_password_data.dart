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
  final String maxAttempteddOtp = "000000";

  // Passwords for testing
  final String newPassword = "NewPassword123!";
  final String weakPassword = "123";

  // Reset tokens for testing
  final String resetToken = "reset_token_123456789abcdef";
  final String expiredResetToken = "expired_token_123";

  /// JSON responses for forgot password request
  final forgotPasswordSuccessJson = {
    "data": [],
    "message": "OTP sent successfully. Please verify your OTP.",
    "status": "success",
  };

  final forgetPasswordErrorJson = {"message": "This number is not registered. Try again or sign up", "status": "error"};

  /// JSON responses for verify OTP request
  Map<String, dynamic> get verifyOtpSuccessJson => {
    "data": {"reset_password_token": resetToken},
    "message": "OTP verified successfully",
    "status": "success",
  };

  final verifyOtpErrorJson = {"message": "Invalid OTP. Please try again.", "status": "error"};

  final expiredOtpErrorJson = {"message": "OTP has expired", "status": "error"};

  final maxAttemptsReachedErrorJson = {
    "message": "You have reached the maximum number of attempts.",
    "status": "error",
  };

  /// JSON responses for reset password request
  final resetPasswordSuccessJson = {
    "data": [],
    "message": "Password reset successful! Log in with your new password.",
    "status": "success",
  };

  final weakPasswordErrorJson = {
    "message": "The password field must be at least 8 characters. (and 1 more error)",
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

  final invalidTokenErrorJson = {"message": "Reset password period is passed", "status": "error"};

  final expiredTokenErrorJson = {"message": "Reset password period is passed", "status": "error"};

  /// JSON responses for resend OTP request
  final resendOtpSuccessJson = {
    "data": {},
    "message": "OTP sent successfully to your phone number",
    "status": "success",
  };
}
