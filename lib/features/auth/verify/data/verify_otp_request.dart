class VerifyOtpRequest {
  final String sessionId;
  final String otpCode;

  VerifyOtpRequest({required this.sessionId, required this.otpCode});

  Map<String, dynamic> toJson() {
    return {'session_id': sessionId, 'otp_code': otpCode};
  }
}
