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

      /// If reasonId is -1, it is "Other Reason" option, we send reasonText instead
      'reason_id': reasonId != -1 ? reasonId : null,
      'reason_text': reasonId == -1 ? reasonText : null,
    };
  }

  copyWith({
    String? otpCode,
    String? sessionId,
    int? reasonId,
    String? reasonText,
  }) {
    return DeleteAccountReq(
      otpCode: otpCode ?? this.otpCode,
      sessionId: sessionId ?? this.sessionId,
      reasonId: reasonId ?? this.reasonId,
      reasonText: reasonText ?? this.reasonText,
    );
  }
}
