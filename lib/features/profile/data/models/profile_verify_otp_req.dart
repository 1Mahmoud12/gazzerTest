class ProfileVerifyOtpReq {
  final String sessionId;
  final String otpCode;

  ProfileVerifyOtpReq({
    required this.sessionId,
    required this.otpCode,
  });

  Map<String, dynamic> toJson() {
    return {'session_id': sessionId, 'otp_code': otpCode};
  }

  copyWith({
    String? sessionId,
    String? otpCode,
  }) {
    return ProfileVerifyOtpReq(
      sessionId: sessionId ?? this.sessionId,
      otpCode: otpCode ?? this.otpCode,
    );
  }
}
