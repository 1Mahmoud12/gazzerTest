class ChangePasswordReq {
  final String currentPassword;
  final String newPassword;

  ChangePasswordReq({required this.currentPassword, required this.newPassword});

  Map<String, dynamic> toJson() {
    return {
      'current_password': currentPassword,
      'password': newPassword,
      'password_confirmation': newPassword,
    };
  }
}
