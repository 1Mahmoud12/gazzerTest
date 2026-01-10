import 'dart:io';

class UpdateProfileReq {
  final String name;
  final String? email;
  final String phone;
  final File? avatar;

  UpdateProfileReq({
    required this.name,
    required this.phone,
    this.email,
    this.avatar,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'phone': phone};
  }
}
