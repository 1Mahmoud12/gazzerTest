class UpdateProfileReq {
  final String name;
  final String? email;
  final String phone;

  UpdateProfileReq({
    required this.name,
    required this.phone,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
