class AuthResponse {
  String msg;
  String? sessionId;

  AuthResponse({required this.msg, required this.sessionId});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      msg: json['message'],
      sessionId: json['data']['session_id'],
    );
  }
}
