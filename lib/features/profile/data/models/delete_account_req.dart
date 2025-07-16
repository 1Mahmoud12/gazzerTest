class DeleteAccountReq {
  final String otpCode;
  final String sessionId;
  final int? reasonId;
  final String? reasonText;

  DeleteAccountReq({
    required this.otpCode,
    required this.sessionId,
    required this.reasonId,
    required this.reasonText,
  });

  Map<String, dynamic> toJson() {
    return {
      'otp_code': otpCode,
      'session_id': sessionId,
      'reason_id': reasonId,
      'reason_text': reasonText,
    };
  }
}
