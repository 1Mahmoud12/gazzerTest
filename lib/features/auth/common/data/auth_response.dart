class AuthResponse {
  final String msg;
  final String sessionId;

  AuthResponse({required this.msg, required this.sessionId});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(msg: json['msg'], sessionId: json['data']['session_id']);
  }
}
